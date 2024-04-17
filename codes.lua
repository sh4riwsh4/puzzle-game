local screen_width = love.graphics.getWidth()
local screen_height = love.graphics.getHeight()
photos = {}
local state = 0
local bttnPointer = love.graphics.newImage("/photos/pointer.png")

buttons = {
	{"basla", imgData , "/photos/B1.png", screen_width/2-50, screen_height/2-70, 140, 60, 1},
	{"bilgi", imgData , "/photos/bilgi.png", screen_width/2-50, screen_height/2+20, 140, 60, 1},
	{"bilgitext", imgData , "/photos/bilgitext.png", 0, screen_height/2-160, 140, 60, 7},
	{"arkaplan", imgData , "/photos/desen.png", 120, 90, 240, 240, 2},
	{"5", imgData , "/photos/5x.png", screen_width/2-100, screen_height/2-120, 100, 50, 2},
	{"6", imgData , "/photos/6x.png", screen_width/2+35, screen_height/2-120, 100, 50, 2},
	{"7", imgData , "/photos/7x.png", screen_width/2-100, screen_height/2-33.5, 100, 50, 2},
	{"8", imgData , "/photos/8x.png", screen_width/2+35, screen_height/2-33.5, 100, 50, 2},
	{"9", imgData , "/photos/9x.png", screen_width/2-100, screen_height/2+55, 100, 50, 2},
	{"10", imgData , "/photos/10x.png", screen_width/2+35, screen_height/2+55, 100, 50, 2},
	{"geri", imgData , "/photos/geri.png", screen_width/2-40, screen_height/2+160, 140, 60, 2},
	{"geri", imgData , "/photos/geri.png", screen_width/2-50, screen_height/2+150, 140, 60, 7},
	{"restart", imgData , "/photos/restart.png", 120, screen_height-50, 40, 40, 3},
	{"resize", imgData , "/photos/resize.png", 250, screen_height-50, 40, 40, 3},
	{"mainmenu", imgData , "/photos/mainmenu.png", 380, screen_height-50, 40, 40, 3},
	{"evet", imgData , "/photos/evet.png", screen_width/2-150, screen_height/2+40, 140, 60, 4},
	{"hayir", imgData , "/photos/hayir.png", screen_width/2+50, screen_height/2+40, 140, 60, 4},
	{"evetgC", imgData , "/photos/evet.png", screen_width/2-150, screen_height/2+40, 140, 60, 9},
	{"hayirgC", imgData , "/photos/hayir.png", screen_width/2+50, screen_height/2+40, 140, 60, 9},
	{"evetmM", imgData , "/photos/evet.png", screen_width/2-150, screen_height/2+40, 140, 60, 10},
	{"hayirmM", imgData , "/photos/hayir.png", screen_width/2+50, screen_height/2+40, 140, 60, 10},
	{"restarttext", imgData , "/photos/text.png", 0, screen_height/2-100, 360, 140, 4},
	{"sizetext", imgData , "/photos/text.png", 0, screen_height/2-100, 360, 140, 9},
	{"menutext", imgData , "/photos/text.png", 0, screen_height/2-100, 360, 140, 10},
	{"wintext", imgData , "/photos/wintext.png", 0, screen_height/2-100, 360, 140, 5},
	{"arkaplan", imgData , "/photos/desen.png", 120, 90, 240, 240, 6},
	{"5", imgData , "/photos/5x.png", screen_width/2-100, screen_height/2-120, 100, 50, 6},
	{"6", imgData , "/photos/6x.png", screen_width/2+35, screen_height/2-120, 100, 50, 6},
	{"7", imgData , "/photos/7x.png", screen_width/2-100, screen_height/2-33.5, 100, 50, 6},
	{"8", imgData , "/photos/8x.png", screen_width/2+35, screen_height/2-33.5, 100, 50, 6},
	{"9", imgData , "/photos/9x.png", screen_width/2-100, screen_height/2+55, 100, 50, 6},
	{"10", imgData , "/photos/10x.png", screen_width/2+35, screen_height/2+55, 100, 50, 6},
	{"gameovertext", imgData , "/photos/gameovertext.png", 0, screen_height/2-100, 100, 50, 8},
}

local function sayilariAyir(sayi)
    if sayi >= 100 then
    	local yuzler = math.floor(sayi/100)
    	sayi = sayi - yuzler*100
    	local onlar = math.floor(sayi/10)
    	sayi = sayi - onlar*10
        return {yuzler, onlar, sayi}
    elseif sayi<100 and sayi>= 10 then
        return {math.floor(sayi/10), sayi%10}
    else
        return {sayi}
    end
end

function butonuBoya()
	local pos1, pos2 = screen_width/2-50, screen_height/2-70
	local pos3, pos4 = screen_width/2-50, screen_height/2+20
	local x, y = love.mouse.getPosition()
    if x>=pos1 and y>=pos2 and x<=pos1+140 and y<=pos2+60 then
		love.graphics.setColor(0.96, 0.96, 0.96, 0.8)
		love.graphics.draw(bttnPointer, 150, screen_height/2-70)
    elseif x>=pos3 and y>=pos4 and x<=pos3+140 and y<=pos4+60 then
		love.graphics.setColor(0.96, 0.96, 0.96, 0.8)
		love.graphics.draw(bttnPointer, 150, screen_height/2+20)
    end
end

function fotolariYukle()
	for ind, val in ipairs(buttons) do
		photos[ind] = love.graphics.newImage(val[3])
	end
end

function winText(gS)
	gS = tostring(gS)
	for ind, val in ipairs(buttons) do
		if val[1] == gS then
			love.graphics.setColor(0.96, 0.96, 0.96, 0.8)
			love.graphics.draw(photos[ind], 330, screen_height/2-80)
		end
		if val[1] == "restart" or val[1] == "resize" or val[1] == "mainmenu" then
			love.graphics.setColor(0.96, 0.96, 0.96, 0.8)
			love.graphics.draw(photos[ind], val[4], val[5])
		end
	end
end

function loseText(mN)
    for i, v in ipairs(sayilariAyir(mN)) do
        love.graphics.draw(nums[v+1], 430+((i-1)*22), screen_height/2-15)
    end
	for ind, val in ipairs(buttons) do
		if val[1] == "restart" or val[1] == "resize" or val[1] == "mainmenu" then
			love.graphics.setColor(0.96, 0.96, 0.96, 0.8)
			love.graphics.draw(photos[ind], val[4], val[5])
		end
	end
end

function butonlariCiz(nmb)
	state = nmb
	for ind, val in ipairs(buttons) do
		if val[8] == nmb then
			if val[1] == "wintext" or val[1] == "gameovertext" or val[1] == "restarttext" or val[1] == "bilgitext" or val[1] == "sizetext" or val[1] =="menutext" then
				love.graphics.setColor(0.96, 0.96, 0.96, 1)
				love.graphics.draw(photos[ind], val[4], val[5])
			else 
			love.graphics.setColor(0.96, 0.96, 0.96, 0.8)
			love.graphics.draw(photos[ind], val[4], val[5])
			end
		end
	end
end

function buttonWork(str)
	if str == "basla" and state == 1 then
		buttonJob(1)
	elseif str == "restart" and (state == 3 or state == 8 or state == 5) then
		buttonJob(2)
		return
	elseif str == "bilgi" and state == 1  then
		buttonJob(4)
	elseif str == "geri" and (state == 2 or state == 7) then
		buttonJob(3)
	elseif str == "evetmM" and state == 10 then
		buttonJob(17)
	elseif str == "evetgC" and state == 9 then
		buttonJob(16)
	elseif str == "evet" and state == 4 then
		buttonJob(0)
	elseif (str == "hayir" or str == "hayirgC" or str == "hayirmM") and (state == 4 or state == 9 or state == 10) then
		buttonJob(11)
	elseif str == "resize" and (state == 3 or state == 8 or state == 5) then
		buttonJob(14)
	elseif (str == "5" or str == "6" or str == "7" or str == "8" or str == "9" or str == "10") and (state == 2 or state == 6) then
		buttonJob(str)
	elseif str == "mainmenu" and (state == 3 or state == 8 or state == 5) then
		buttonJob(15)
	end
end

function baslangicButonlari(v1, v2)
	for ind, val in ipairs(buttons) do
		if v1>=val[4] and v2>=val[5] and v1<=val[4]+val[6] and v2<=val[5]+val[7] then
			buttonWork(val[1])
		end
	end
end