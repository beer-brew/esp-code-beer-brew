pin = 1
count = 0
volume_in_ml = 0
on_volume_callback = nil
on_volume_log = nil
red_pin = 2
green_pin = 3


function on_volume(volume, callback, log)
    count = 0
    volume_in_ml = volume
    on_volume_callback = callback
    on_volume_log = log
end

function onChange ()
    count = count + 1
    print('flow' .. count)
    gpio.write(red_pin, gpio.LOW)
    gpio.write(green_pin, gpio.HIGH)
    on_volume_log('starting to pour: ' .. count * 2.07)
    if (count * 2.07 > volume_in_ml) then
        print('stop at ' .. count * 2.07)
        gpio.write(red_pin, gpio.HIGH)
        gpio.write(green_pin, gpio.LOW)
        on_volume_callback()
        on_volume_log('finished pouring: ' .. count * 2.07)
    end
end

gpio.mode(pin, gpio.INT, gpio.PULLUP)
gpio.trig(pin, 'both', onChange)

gpio.mode(red_pin, gpio.OUTPUT)
gpio.write(red_pin, gpio.HIGH)

gpio.mode(green_pin, gpio.OUTPUT)
gpio.write(green_pin, gpio.LOW)


--function hello()
--    print("reached volume")
--end
--
--function log(str)
--    print(str)
--end
--
--on_volume(100, hello, log )
