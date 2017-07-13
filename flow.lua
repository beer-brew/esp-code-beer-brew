pin = 1
count = 0
volume_in_ml = 0
on_volume_callback = nil
red_pin = 2
green_pin = 3
gpio.mode(pin, gpio.INT, gpio.PULLUP)

function on_volume(volume, callback)
    count = 0
    volume_in_ml = tonumber(volume)
    on_volume_callback = callback
	volume_in_ticks = (volume * 440) / 1000
    gpio.trig(pin, 'down', onChange)
end

function onChange ()
    count = count + 1
    print('flow' .. count)
    gpio.write(red_pin, gpio.LOW)
    gpio.write(green_pin, gpio.HIGH)
    print('starting to pour: ' .. count)
    if (count > volume_in_ticks) then
        print('stop at ' .. count)
        gpio.write(red_pin, gpio.HIGH)
        gpio.write(green_pin, gpio.LOW)
        on_volume_callback()
        print('finished pouring: ' .. count)
        gpio.trig(pin, 'none')
    end
end

gpio.mode(red_pin, gpio.OUTPUT)
gpio.write(red_pin, gpio.HIGH)

gpio.mode(green_pin, gpio.OUTPUT)
gpio.write(green_pin, gpio.LOW)
