local screen_width = love.graphics.getWidth()
local screen_height = love.graphics.getHeight()
local doluGrid = {nil}
local possibleMovesList = {nil}
local gridSize = 0
local possibleMoveNumber = love.graphics.newImage("/photos/hamle.png")
nums = {nil}

function resetVariables(gS)
    doluGrid = {nil}
    possibleMovesList = {nil}
    gridSize = gS
end

local sayilar = {
    {"0", imgData , "/photos/0.png", screen_width/2+35, screen_height/2+55, 100, 50},
    {"1", imgData , "/photos/1.png", screen_width/2-100, screen_height/2-120, 100, 50},
    {"2", imgData , "/photos/2.png", screen_width/2-100, screen_height/2-120, 100, 50},
    {"3", imgData , "/photos/3.png", screen_width/2-100, screen_height/2-120, 100, 50},
    {"4", imgData , "/photos/4.png", screen_width/2-100, screen_height/2-120, 100, 50},
    {"5", imgData , "/photos/5.png", screen_width/2-100, screen_height/2-120, 100, 50},
    {"6", imgData , "/photos/6.png", screen_width/2+35, screen_height/2-120, 100, 50},
    {"7", imgData , "/photos/7.png", screen_width/2-100, screen_height/2-33.5, 100, 50},
    {"8", imgData , "/photos/8.png", screen_width/2+35, screen_height/2-33.5, 100, 50},
    {"9", imgData , "/photos/9.png", screen_width/2-100, screen_height/2+55, 100, 50},
}

function sayilariYukle()
    for ind, val in ipairs(sayilar) do
        nums[ind] = love.graphics.newImage(val[3])
    end
end

local function sayilariAyir(sayi)
    if sayi == 0 then sayi = gridSize*gridSize end
    if sayi == 100 then
        return {1,0,0}
    elseif sayi<100 and sayi>= 10 then
        return {math.floor(sayi/10), sayi%10}
    else
        return {sayi}
    end
end

local function tabloyaEkle(val1, val2, val3)
    if val1>=x1 and val2>=y1 and val1<=x3-30 and val2<=y3-30 then
        local check = true
        for ind, val in ipairs(doluGrid) do
            if val[1] == val1 and val[2] == val2 then
                check = false
            end
        end
        if check then
            table.insert(doluGrid, {val1,val2,val3})
            return
        end
        return
    end
end

local function tablodaMi(val1, val2, tabl)
    local check = false
    local tabl = tabl or doluGrid
    for ind, val in ipairs(tabl) do
        if val[1] == val1 and val[2] == val2 then
            check = true
        end
    end
    if check then
        return true
    end
    return false
end

function gameOver()
    if #possibleMovesList == 0 and #doluGrid ~= 0 then
        return true
    end
    return false
end

function possibleMovesDraw(check)
    if not check then
        local hamleSayisi = #possibleMovesList
        local scSize = screen_width/2
        if gridSize == "5" or gridSize == "7" or gridSize == "9" then
            scSize = screen_width/2 + 15
        end
        for ind, val in ipairs(possibleMovesList) do
            love.graphics.push()
            love.graphics.setColor(1, 0, 0, 0.4)
            love.graphics.rectangle("fill", val[1], val[2], 30, 30)
            love.graphics.pop()
        end
        love.graphics.push()
        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.draw(possibleMoveNumber, scSize-100, y3*1.1)
        for i, v in ipairs(sayilariAyir(hamleSayisi)) do
            love.graphics.draw(nums[v+1], scSize+(100+((i-1)*22)), y3*1.1)
        end
        love.graphics.pop()
    else
        love.graphics.push()
        love.graphics.setColor(0, 0, 0, 0.8)
        if #doluGrid == gridSize*gridSize then
            buttonJob(12)
        else
            buttonJob(13, #doluGrid)
        end
        love.graphics.pop()        
    end
end

function possibleMoves()
    local len = #doluGrid
    local sayac = 0
    if len>0 then
        local xPos = doluGrid[len][1]
        local yPos = doluGrid[len][2]
        possibleMovesList = {nil}
        if xPos-60>=x1 and yPos+30<y3 then
            if not tablodaMi(xPos-60,yPos+30) then
                table.insert(possibleMovesList, {xPos-60, yPos+30})
                sayac = sayac + 1
            end
        end
        if xPos-60>=x1 and yPos-30>=y1 then
            if not tablodaMi(xPos-60, yPos-30) then
                table.insert(possibleMovesList, {xPos-60, yPos-30}) 
                sayac = sayac + 1             
            end
        end
        if xPos+60<x2 and yPos+30<y3 then
            if not tablodaMi(xPos+60, yPos+30) then
                table.insert(possibleMovesList, {xPos+60, yPos+30})
                sayac = sayac + 1
            end            
        end
        if xPos+60<x2 and yPos-30>=y1 then
            if not tablodaMi(xPos+60, yPos-30) then
                table.insert(possibleMovesList, {xPos+60, yPos-30})
                sayac = sayac + 1              
            end
        end
        if xPos+30<x2 and yPos-60>=y1 then
            if not tablodaMi(xPos+30, yPos-60) then
                table.insert(possibleMovesList, {xPos+30, yPos-60})
                sayac = sayac + 1              
            end
        end
        if xPos-30>=x1 and yPos-60>=y1 then
            if not tablodaMi(xPos-30, yPos-60) then
                table.insert(possibleMovesList, {xPos-30, yPos-60})
                sayac = sayac + 1              
            end
        end
        if xPos+30<x2 and yPos+60<y3 then
            if not tablodaMi(xPos+30, yPos+60) then
                table.insert(possibleMovesList, {xPos+30, yPos+60})
                sayac = sayac + 1              
            end
        end
        if xPos-30>=x1 and yPos+60<y3 then
            if not tablodaMi(xPos-30, yPos+60) then
                table.insert(possibleMovesList, {xPos-30, yPos+60})
                sayac = sayac + 1              
            end
        end
    end
    return sayac
end

function gridCiz()
    love.graphics.setBackgroundColor(0.96, 0.96, 0.96)
    for i=30, screen_height, 30 do
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.line(0, i, screen_width, i)
        if i > 60 then
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.line(i, 0, i, screen_height)
        elseif i == 60 then
            love.graphics.setColor(255, 0, 0, 0.7)
            love.graphics.line(i, 0, i, screen_height)
        end
    end
end

function sinirlariCiz(val)
    gridSize = val
    local baslangicX = screen_width/2
    local baslangicY = screen_height/2-60
    while baslangicX%30 ~= 0 do
        baslangicX = baslangicX + 1
    end
    while baslangicY%30 ~= 0 do
        baslangicY = baslangicY + 1
    end
    x1, y1 = baslangicX-(30*math.floor(val/2)), baslangicY-(30*math.floor(val/2)) -- sol üst köşe
    x2, y2 = baslangicX+(30*math.ceil(val/2)), baslangicY-(30*math.floor(val/2)) -- sağ üst köşe
    x3, y3 = baslangicX+(30*math.ceil(val/2)), baslangicY+(30*math.ceil(val/2)) -- sağ alt köşe
    x4, y4 = baslangicX-(30*math.floor(val/2)), baslangicY+(30*math.ceil(val/2)) -- sol alt köşe
    love.graphics.setColor(0, 0, 255, 0.8)
    love.graphics.line(x1, y1, x2, y2, x3, y3, x4, y4, x1, y1) -- üst kenar  
    for i=30, val*30, 30 do
        love.graphics.setColor(0, 0, 255, 0.4)
        love.graphics.line(x1, y1+i, x2, y2+i)
        love.graphics.line(x4+i, y4, x1+i, y1)
    end 
end

function kareyiBoya(val)
	local x, y = love.mouse.getPosition()
    local sayi = #doluGrid
	x = (math.floor(x/30))*30
	y = (math.floor(y/30))*30
	if not tablodaMi(x, y) then
        if x>=x1 and y>=y1 and x<=x3-30 and y<=y3-30 then
    		love.graphics.setColor(0, 0, 0, 0.7)
            if sayi<=9 then
                love.graphics.print(sayi+1, x+10, y+8)
            elseif sayi<=99 and sayi>=10 then
                love.graphics.print(sayi+1, x+6, y+8)    
            elseif sayi==100 then
                love.graphics.print(sayi+1, x+3, y+8)
            end
    	end
    end
end

function sayiyiYaz(v1, v2)
    if v1 and v2 then
        v1 = (math.floor(v1/30))*30
        v2 = (math.floor(v2/30))*30
        if #possibleMovesList > 0 then
            if tablodaMi(v1, v2, possibleMovesList) then
                tabloyaEkle(v1,v2)
                possibleMoves()
            end
        else
            tabloyaEkle(v1,v2)
            possibleMoves()
        end
    end
end

function sayiyiKareyeKoy()
    for ind, val in ipairs(doluGrid) do
        love.graphics.setColor(0, 0, 0, 0.8)
        if ind<=9 then
            love.graphics.print(ind, val[1]+10, val[2]+8)
        elseif ind<=99 and ind>=10 then
            love.graphics.print(ind, val[1]+6, val[2]+8)    
        elseif ind==100 then
            love.graphics.print(ind, val[1]+3, val[2]+8)
        end
    end 
end