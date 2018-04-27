/*

	- TO DO LIST
	- 3D Health Bars for apothecaries
	- Squad system
	- Stamina, Health, Armor
	- 
*/
nut.bar = nut.bar or {}
nut.bar.list = {}
nut.bar.delta = nut.bar.delta or {}
nut.bar.actionText = ""
nut.bar.actionStart = 0
nut.bar.actionEnd = 0

local width = ScrW()
local height = ScrH()
local maxWidth = (width * 0.05) * 4
local startWidth = width/2 - ((width * 0.05)*2)

local aimDirs = {}

aimDirs[360] = "N"
aimDirs[0] = "N"
aimDirs[45] = "NE"
aimDirs[90] = "E"
aimDirs[135] = "SE"
aimDirs[180] = "S"
aimDirs[225] = "SW"
aimDirs[270] = "W"
aimDirs[315] = "NW"

local numsDir = {}
numsDir[0] = -3
numsDir[1] = -2
numsDir[2] = -1
numsDir[3] = 0
numsDir[4] = 1
numsDir[5] = 2
numsDir[6] = 3


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
local text1 = false

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
	
	--draw.SimpleText((math.Round( (value * 100), 1 )), "CenturyGothic", x + w*.03, y + h/2 - 2, color_white, 3, 1)
	
end
	
function nut.bar.drawSquadHP(x, y, w, h, client)
		nut.util.drawBlurAt(x, y, w, h)

		surface.SetDrawColor(255, 255, 255, 15)
		surface.DrawRect(x, y, w, h)
		surface.DrawOutlinedRect(x, y, w, h)

		x, y, w, h = x + 2, y + 2, (w - 4) * (client:Health() / client:GetMaxHealth()), (h - 4)

		surface.SetDrawColor(150, 30, 20, 250)
		surface.DrawRect(x, y, w, h)
	
		surface.SetDrawColor(255, 255, 255, 8)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(x, y, w, h)
		
		
end	

function nut.bar.drawSquadArmor(x, y, w, h, client)
		nut.util.drawBlurAt(x, y, w, h)

		surface.SetDrawColor(255, 255, 255, 15)
		surface.DrawRect(x, y, w, h)
		surface.DrawOutlinedRect(x, y, w, h)

		x, y, w, h = x + 2, y + 2, (w - 4) * (client:Armor() / 500), (h - 4)

		surface.SetDrawColor(255, 215, 0, 250)
		surface.DrawRect(x, y, w, h)
	
		surface.SetDrawColor(255, 255, 255, 8)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(x, y, w, h)
		
		draw.SimpleText(client:Nick(), "CenturyGothicSmall", x + w*.03, y + h + 15, color_white, 3, 1)
end	


local TEXT_COLOR = Color(240, 240, 240)
local SHADOW_COLOR = Color(20, 20, 20)

local Approach = math.Approach
local hp = nut.util.getMaterial("vgui/redbar.png")
local armor = nut.util.getMaterial("vgui/Armor.png")
local stm = nut.util.getMaterial("vgui/marine.png")
local psy = nut.util.getMaterial("vgui/psyker.png")
local hpborder1 = nut.util.getMaterial("vgui/border_1.png")
local hpborder2 = nut.util.getMaterial("vgui/border_2.png")
local hpborder3 = nut.util.getMaterial("vgui/border_3.png")
local hpbar1 = nut.util.getMaterial("vgui/border_icon_1.png")
local hpbar2 = nut.util.getMaterial("vgui/border_icon_2.vmt")
local hpbar3 = nut.util.getMaterial("vgui/border_icon_3.png")
local hpbar4 = nut.util.getMaterial("vgui/border_icon_4.png")

BAR_HEIGHT = 10
function DrawBorder( client )
local len = ( math.min(client:Health(),client:GetMaxHealth() ) / 5) 
local len2 = 35 + ( client:GetMaxHealth() / 5)

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hpborder2 )
	surface.DrawTexturedRect( ScrW() * 0.05, 80, len2 - 100, 38)
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hpborder1 )
	surface.DrawTexturedRect( ScrW() * 0.040, 80, 48, 38)
	
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial( hpborder3 )
	surface.DrawTexturedRect( ScrW() * 0.05 + len2 - 135, 80, 139, 38)
end

function DrawHealth( client )
local len = ( math.min(client:Health(),client:GetMaxHealth() ) / 5) 
local len2 = 110 + ( client:GetMaxHealth() / 5)

	if LocalPlayer():Alive() then
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( hpbar1 )
		surface.DrawTexturedRect( ScrW() * 0.023, 80, 38, 38)
	end
	
	
	DrawStm( LocalPlayer() )
	DrawArmor( LocalPlayer() )
	DrawBorder( LocalPlayer() )
	
	
	if LocalPlayer():Alive() then	
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial( hpbar2 )
		surface.DrawTexturedRectUV( ScrW() * 0.043 + 7, 90, len, 20, 0, 0, 1, 1 )
	
		render.SetScissorRect( ScrW() * 0.043, 90, ScrW() * 0.043 + 7, 110, true )
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial( hpbar3 )
			surface.DrawTexturedRectUV( ScrW() * 0.043, 90, 26, 20, 0, 0, 1, 1 )
		render.SetScissorRect( 0, 0, 0, 0, false ) -- Disable after you are done
	end
end

function DrawArmor( client )
local len = ScrW() * 0.04 + client:Armor()
local len2 = 45 + 5000

local col = Color(255, 255, 0)

	local armor = {
		{
			x = ScrW() * 0.04,
			y = 83
		},
		{
			x = math.max ( ScrW() * 0.04 ,len ),	
			y = 83
		},
		{
			x = math.max ( ScrW() * 0.04, len),	
			y = 90
		},
		{
			x = ScrW() * 0.043, 	
			y = 90
		},
	}
	local armor2 = {
		{
			x = ScrW() * 0.043,
			y = 105
		},
		{
			x = math.max ( ScrW() * 0.04 ,len ),	
			y = 105
		},
		{
			x = math.max ( ScrW() * 0.04, len),	
			y = 117
		},
		{
			x = ScrW() * 0.04, 	
			y = 117
		},
	}
	
	surface.SetDrawColor( col )
	draw.NoTexture()
	surface.DrawPoly( armor )
	
	surface.SetDrawColor( col )
	draw.NoTexture()
	surface.DrawPoly( armor2 )
	
end

function DrawStm( client )
local len = ScrW() * 0.04 + LocalPlayer():getLocalVar("stm", 0) * 2
local len2 = 90

local col = Color(0, 115, 0)

	local stm = {
		{
			x = ScrW() * 0.04,
			y = 130
		},
		{
			x = math.max ( ScrW() * 0.04 ,len ),	
			y = 130
		},
		{
			x = math.max ( ScrW() * 0.04, len),	
			y = 150
		},
		{
			x = ScrW() * 0.04, 	
			y = 150
		},
	}
	
	DrawPsy( LocalPlayer() )
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hpborder2 )
	surface.DrawTexturedRect( ScrW() * 0.05, 120, len2, 38)
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hpborder1 )
	surface.DrawTexturedRect( ScrW() * 0.040, 120, 48, 38)
	
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial( hpborder3 )
	surface.DrawTexturedRect( ScrW() * 0.05 + len2, 120, 139, 38)
	
	surface.SetDrawColor( col )
	draw.NoTexture()
	surface.DrawPoly( stm )
	
end

function DrawPsy( client )
local len = ScrW() * 0.04 + LocalPlayer():getLocalVar("psy", 0) * 2

local col = Color(150, 20, 150)

	local psy1 = {
		{
			x = ScrW() * 0.04,
			y = 123
		},
		{
			x = math.max ( ScrW() * 0.04 ,len ),	
			y = 123
		},
		{
			x = math.max ( ScrW() * 0.04, len),	
			y = 128
		},
		{
			x = ScrW() * 0.043, 	
			y = 128
		},
	}
	local psy2 = {
		{
			x = ScrW() * 0.043,
			y = 145
		},
		{
			x = math.max ( ScrW() * 0.04 ,len ),	
			y = 145
		},
		{
			x = math.max ( ScrW() * 0.04, len),	
			y = 158
		},
		{
			x = ScrW() * 0.04, 	
			y = 158
		},
	}
	
	surface.SetDrawColor( col )
	draw.NoTexture()
	surface.DrawPoly( psy1 )
	
	surface.SetDrawColor( col )
	draw.NoTexture()
	surface.DrawPoly( psy2 )
	
end
	
function nut.bar.drawAll()
	if (hook.Run("ShouldHideBars")) then
		return
	end
	
	local players = (team.NumPlayers(LocalPlayer():Team()))
	if !IsValid(iconmodel) then 
	
			print("Setting up hud model")
			iconmodel = vgui.Create("nutSquad")
			iconmodel:SetPos(ScrW() * 0.02, ScrH() / 3)
			iconmodel:SetSize(64,(64 * (players - 1)))
			iconmodel:ParentToHUD()
			timer.Create("SquadRefresh", 30, 0, function() 
			iconmodel:Remove()
			end)
	end
	
	
	
	
	DrawHealth( LocalPlayer() )
	
	local w, h = surface.ScreenWidth() * 0.10, BAR_HEIGHT
	local x, y = ScrW() * 0.02 + 70, ScrH() / 3
	local deltas = nut.bar.delta
	local frameTime = FrameTime()
	local curTime = CurTime()
	
	
	for k, v in ipairs(team.GetPlayers(LocalPlayer():Team())) do
		--print(v)
		--print(LocalPlayer())
		if v == LocalPlayer() then
		
		else
			nut.bar.drawSquadHP(x, y, w, h, v)
			y = y + h
			nut.bar.drawSquadArmor(x, y, w, h, v)
			
			y = y + h + 60
			
		end
	end
	/*
	for i = 1, #nut.bar.list do
		local bar = nut.bar.list[i]
		
		if (bar) then
			local realValue = bar.getValue()
			
				nut.bar.draw(x, y, w, h + 10, realValue, bar.color, bar)
				y = y + h + 20
				
					
					
					
			end
	end
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hp )
	surface.DrawTexturedRect( 60, 105, 30, 30)
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( armor )
	surface.DrawTexturedRect( 60, 135, 30, 30)*/
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( stm )
	surface.DrawTexturedRect( 40, 125, 35, 35)

	nut.bar.drawAction() 
	
	local dirWidth = (width / 20) 
	local dirStartWidth = (dirWidth* 10) + (dirWidth * 3)

	local aimDir =   359 - math.floor(math.NormalizeAngle( LocalPlayer():EyeAngles().yaw) + 180)

	draw.SimpleText( aimDir,"CenturyGothic",width/2, 16,Color(255, 255, 255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
	local offset = 0

	for i=0,6 do
		local dived = (math.floor((aimDir )/45)) 
		local tempDir = 45 * ((dived - numsDir[(i )] + offset) % 9)


		if aimDir <= 134 && tempDir >= 270 then
			offset = -45
		else
			if aimDir <= 90 then
				offset = 0
			end
		end 
		if aimDir >= 270 && tempDir <  135 then
			offset = 45
		else
			if aimDir >= 270 then
				offset = 0
			end
		end 


		tempDir = tempDir + offset

		draw.SimpleText( aimDirs[tempDir] or tempDir ,"CenturyGothic",dirStartWidth - (i* dirWidth) - (((aimDir % 45)/45) * dirWidth) , 16 + 25,Color(255, 255, 255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
	end
	
	
	
	
	
end