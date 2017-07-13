HOST = "m10.cloudmqtt.com"
PORT = "12948"
USER_NAME = "qegbzezg"
PASSWORD = "GaD8XPkgNZMH"
VALVE_PIN = 4

gpio.mode(VALVE_PIN, gpio.OUTPUT)

function turn_off_valve()
    print('Turn off valve')
    gpio.write(VALVE_PIN, gpio.LOW)
end

turn_off_valve()

wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="HUAWEI-34EC"
station_cfg.pwd="05701211"
station_cfg.save=true
wifi.sta.connect(station_cfg)

function connect_to_mqtt_broker()
    client = mqtt.Client(node.chipid(),30000,USER_NAME,PASSWORD, 1)
    client:connect(HOST, PORT, 0, on_connect)
    client:on('offline', on_disconnect)
    client:on('message', on_message)
end

function on_connect()
  print('Connected to MQTT server')
  dofile('flow.lua')
  client:subscribe( '/givemebeer/'..node.chipid(), 0)
end


function on_message(conn, topic, data)
   if topic=='/givemebeer/' .. node.chipid() then
     print(topic .. '#:' .. data) 
     on_volume(data, turn_off_valve)       
     turn_on_valve()  
   end 
end

function on_disconnect()
    print('Disconnected from MQTT server')
end

function turn_on_valve()
    print('Turn on valve')
    gpio.write(VALVE_PIN, gpio.HIGH)
end


connect_to_mqtt_broker()
