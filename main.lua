local screen_width = love.graphics.getWidth()
local screen_height = love.graphics.getHeight()
local oyunBasladi = false
local oyunBitti = true
local rowNum = 0
local maxNumb = 0
local state = 1
local mouse = love.graphics.newImage("/photos/mouse.png")
love.mouse.setVisible(false)

require("grids")
require("codes")

function love.load()
    sayilariYukle()
    fotolariYukle()
end

local function mouseCiz()
    local posX, posY = love.mouse.getPosition()
    love.graphics.push()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(mouse, posX, posY)
    love.graphics.pop()
end

function buttonJob(numb, maxNum)
    maxNum = maxNum or 0
    maxNumb = maxNum
    if numb == 1 then
        state = 2
        return
    elseif numb == 2 then
        if (state == 5 or state == 8) then
            resetVariables(rowNum)
            maxNumb = 0
            oyunBasladi = true
            oyunBitti = false
            state = 3
            return      
        end
        state = 4
        return
    elseif numb == 3 then
        state = 1
        return
    elseif numb == 4 then
        state = 7
        return
    elseif numb == 0 then
        resetVariables(rowNum)
        maxNumb = 0
        oyunBasladi = true
        oyunBitti = false
        state = 3      
    elseif numb == 11 then
        state = 3
    elseif numb == 12 then
        state = 5
    elseif numb == 13 then
        state = 8
    elseif numb == 14 then
        if (state == 5 or state == 8) then
            oyunBasladi = false
            oyunBitti = true
            maxNumb = 0
            resetVariables(rowNum)
            state = 6
            return
        end
        state = 9
    elseif numb == 15 then
        if (state == 5 or state == 8) then
            resetVariables(rowNum)
            oyunBasladi = false
            oyunBitti = true
            rowNum = 0
            maxNumb = 0
            state = 1    
            return
        end
        state = 10
    elseif numb == 16 then
        oyunBasladi = false
        oyunBitti = true
        maxNumb = 0
        resetVariables(rowNum)
        state = 6
    elseif numb == 17 then
        resetVariables(rowNum)
        oyunBasladi = false
        oyunBitti = true
        rowNum = 0
        maxNumb = 0
        state = 1    
    else
        rowNum = numb
        oyunBasladi = true
        oyunBitti = false
        state = 3
        return
    end
end

function love.update(dt)
    if not oyunBitti then
        oyunBitti = gameOver()
    end
end

function love.mousereleased(x, y, button)
    if not oyunBitti then
        if button == 1 then
            if state == 3 then
                sayiyiYaz(x, y)
            end
        end
    end
    if button == 1 then
        baslangicButonlari(x, y)
    end
end

function love.draw()
    gridCiz()
    if state ~= 4 or state ~= 0 or state ~= 10 then
        if oyunBasladi then
            sinirlariCiz(rowNum)
            if state == 3 then
                kareyiBoya(rowNum)
            end
            sayiyiKareyeKoy()
            possibleMovesDraw(oyunBitti)
        end
    end
    butonlariCiz(state)
    if state == 5 then winText(rowNum) end
    if state == 8 then loseText(maxNumb) end
    if state == 1 then butonuBoya() end
    mouseCiz()
end