nut.bar = nut.bar or {}
nut.bar.list = {}
nut.bar.delta = nut.bar.delta or {}
nut.bar.actionText = ""
nut.bar.actionStart = 0
nut.bar.actionEnd = 0

function nut.bar.get(identifier)
	for i = 1, #nut.bar.list do
		local bar = nut.bar.list[i]
		
		if (bar and bar.identifier == identifier) then
			return bar
		end
	end
end

function nut.bar.add(getValue, color, priority, identifier)
	if (identifier) then
		local oldBar = nut.bar.get(identifier)
		
		if (oldBar) then
			table.remove(nut.bar.list, oldBar.priority)
		end
	end

	priority = priority or table.Count(nut.bar.list) + 1

	local info = nut.bar.list[priority]

	nut.bar.list[priority] = {
		getValue = getValue,
		color = color or info.color or Color(math.random(150, 255), math.random(150, 255), math.random(150, 255)),
		priority = priority,
		lifeTime = 0,
		identifier = identifier
	}

	return priority
end

local color_dark = Color(0, 0, 0, 225)
local gradient = nut.util.getMaterial("vgui/gradient-u")
local gradient2 = nut.util.getMaterial("vgui/gradient-d")
local surface = surface

function nut.bar.draw(x, y, w, h, value, color)
	nut.util.drawBlurAt(x, y, w, h)

	surface.SetDrawColor(255, 255, 255, 15)
	surface.DrawRect(x, y, w, h)
	surface.DrawOutlinedRect(x, y, w, h)

	x, y, w, h = x + 2, y + 2, (w - 4) * math.min(value, 1), h - 4

	surface.SetDrawColor(color.r, color.g, color.b, 250)
	surface.DrawRect(x, y, w, h)

	surface.SetDrawColor(255, 255, 255, 8)
	surface.SetMaterial(gradient)
	surface.DrawTexturedRect(x, y, w, h)
	
	draw.SimpleText((math.Round( (value * 100), 1 )), "CenturyGothic", x + w*.03, y + h/2 - 2, color_white, 3, 1)
end	

local TEXT_COLOR = Color(240, 240, 240)
local SHADOW_COLOR = Color(20, 20, 20)

local Approach = math.Approach
local hp = nut.util.getMaterial("vgui/hp.png")
local armor = nut.util.getMaterial("vgui/Armor.png")
local stm = nut.util.getMaterial("vgui/marine.png")
local psy = nut.util.getMaterial("vgui/psyker.png")

BAR_HEIGHT = 10

function nut.bar.drawAll()
	if (hook.Run("ShouldHideBars")) then
		return
	end
	
	local w, h = surface.ScreenWidth() * 0.35, BAR_HEIGHT
	local x, y = 4, 4
	local deltas = nut.bar.delta
	local frameTime = FrameTime()
	local curTime = CurTime()
	local updateValue = frameTime * 1.2
	
	for i = 1, #nut.bar.list do
		local bar = nut.bar.list[i]
		
		if (bar) then
			local realValue = bar.getValue()
			local value = Approach(deltas[i] or 0, realValue, updateValue)
			
			deltas[i] = value
			
			if (deltas[i] != realValue) then
				bar.lifeTime = curTime + 10
			end
			
				nut.bar.draw(x + 100, y, w, h + 10, value, bar.color, bar)
				y = y + h + 20
				
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( hp )
					surface.DrawTexturedRect( 60, 0, 30, 30)
	
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( armor )
					surface.DrawTexturedRect( 60, 30, 30, 30)
					
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( stm )
					surface.DrawTexturedRect( 60, 60, 25, 25)
					
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( psy )
					surface.DrawTexturedRect( 60, 90, 25, 25)
					
		end
	end

	nut.bar.drawAction()
end

do
	nut.bar.add(function()
		return LocalPlayer():Health() / LocalPlayer():GetMaxHealth()
	end, Color(150, 30, 20), nil, "health")

	nut.bar.add(function()
		return math.min(LocalPlayer():Armor() / 100, 1)
	end, Color(30, 37, 101), nil, "armor")
	
	nut.bar.add(function()
		return LocalPlayer():getLocalVar("stm", 0) / 100
	end, Color(55, 115, 40), nil, "stm")
	
end