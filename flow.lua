pin = 1
count = 0

function onChange ()
    count = count + 1
    print('flow' .. count)
    if (count % 483 == 0) then
        print('= liter')
    end
end

gpio.mode(pin, gpio.INT, gpio.PULLUP)
gpio.trig(pin, 'both', onChange)