local x, y, secAngle, minAngle, hourAngle, timeStr, timeStrFont, background

function getTimeStr(hour, min, sec)
    local hs = hour < 10 and string.format("0%s", hour) or hour
    local ms = min < 10 and string.format("0%s", min) or min
    local ss = sec < 10 and string.format("0%s", sec) or sec
    return string.format("%s : %s : %s", hs, ms, ss)
end

function getWeekdayStr(wday)
    t = {}
    t[0] = "SUN"
    t[1] = "MON"
    t[2] = "TUE"
    t[3] = "WED"
    t[4] = "THUR"
    t[5] = "FRI"
    t[6] = "SAT"
    return t[wday]
end

function love.load()
    x = love.graphics.getWidth() / 2
    y = love.graphics.getHeight() / 2
    secAngle = 0
    minAngle = 0
    hourAngle = 0
    timeStrFont = love.graphics.newFont("fonts/static/Orbitron-Regular.ttf", 30)
    background = love.graphics.newImage("background.jpg")
end

function love.update(dt)
    local time = os.date("*t")
    local hour = time.hour
    local min = time.min
    local sec = time.sec
    day = getWeekdayStr(time.wday)
    timeStr = getTimeStr(hour, min, sec)

    hourAngle = ((hour / 12) * math.pi * 2)
    minAngle = ((min / 60) * math.pi * 2)
    secAngle = ((sec / 60) * math.pi * 2)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function drawRotateRect(x, y, width, height, angle)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate((-math.pi / 2) + angle)
    love.graphics.rectangle("line", 0, 0, width, height)
    love.graphics.pop()
end

function love.draw()
    love.graphics.draw(background, 0, 0, 0, 0.6, 0.6)
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(0, 0, 0)
    drawRotateRect(x, y, 250, 2, secAngle)
    drawRotateRect(x, y, 200, 4, minAngle)
    drawRotateRect(x, y, 100, 6, hourAngle)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(
        timeStr,
        timeStrFont,
        love.graphics.getWidth() / 2 - (timeStrFont:getWidth(timeStr) / 2),
        love.graphics.getHeight() - timeStrFont:getHeight() - 10
    )
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(day, timeStrFont, love.graphics.getWidth() / 2 - (timeStrFont:getWidth(day) / 2), 10)
    love.graphics.setColor(1, 1, 1)
end
