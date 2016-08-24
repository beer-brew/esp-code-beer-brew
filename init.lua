HOST = "m10.cloudmqtt.com"
PORT = "12948"
USER_NAME = "qegbzezg"
PASSWORD = "GaD8XPkgNZMH"

VALVE_PIN = 4
gpio.mode(VALVE_PIN, gpio.OUTPUT)

enduser_setup.start(
   function()
     print('Connection WIFI')
   end, 
   function(err, str)
     print('ERROR:'..err)
   end
)

function log(message) 
    print(message)
end

function on_connect()
  log('Connected to MQTT server')
  dofile('flow.lua')
  client:subscribe( '/givemebeer/'..node.chipid(), 0)
end

function on_message(conn, topic, data)
   if topic=='/givemebeer/' .. node.chipid() then
     local data_json=cjson.decode(data)
     log(topic .. '#:' .. data_json['volume']) 
     on_volume(data_json['volume'], turn_off_valve, log)       
     turn_on_valve()  
   end 
end

function on_disconnect()
    log('Disconnected from MQTT server')
end

function turn_on_valve()
    log('Turn on valve')
    gpio.write(VALVE_PIN, gpio.HIGH)
end

function turn_off_valve()
    og('Turn off valve')
    gpio.write(VALVE_PIN, gpio.LOW)
end

function connect_to_mqtt_broker()
    client = mqtt.Client(node.chipid(), 30000, USER_NAME, PASSWORD)
    client:connect(HOST, PORT, 0, on_connect)
    client:on('offline', on_disconnect)
    client:on('message', on_message)
end