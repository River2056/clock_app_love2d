local x, y, secAngle, minAngle, hourAngle

function love.load()
    x = love.graphics.getWidth() / 2
    y = love.graphics.getHeight() / 2
    secAngle = 0
    minAngle = 0
    hourAngle = 0
end

function love.update(dt)
    local time = os.date('*t')
    local hour = time.hour
    local min = time.min
    local sec = time.sec

    hourAngle = ((hour / 12) * math.pi * 2)
    minAngle = ((min / 60) * math.pi * 2)
    secAngle = ((sec / 60) * math.pi * 2)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function drawRotateRect(x, y, width, height, angle)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate((-math.pi / 2) + angle)
    love.graphics.rectangle('line', 0, 0, width, height)
    love.graphics.pop()
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(1, 1, 1)
    drawRotateRect(x, y, 250, 2, secAngle)
    drawRotateRect(x, y, 200, 4, minAngle)
    drawRotateRect(x, y, 100, 6, hourAngle)
end