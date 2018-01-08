/*surface.CreateFont("nutNumeric", {
    font = "nutMediumFont",
    size = ScreenScale(10),
    weight = 500,
    extended = true,   
})
surface.CreateFont("nutNumericName", {
    font = "nutMediumFont",
    size = ScreenScale(10),
    weight = 500,
    extended = true,   
})
 
 
surface.CreateFont("nutHUDNumeric", {
    font = "nutMediumFont",
    size = ScreenScale(10),
    weight = 500,
    extended = true,   
    shadow = true,
})
surface.CreateFont("nutHUDNumericName", {
    font = "nutMediumFont",
    size = ScreenScale(7),
    weight = 500,
    extended = true,   
    shadow = true,
})
surface.CreateFont( "NobberFont", {
	font = "Century Gothic", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = ScreenScale(9),
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local gap = 1
local function drawBar(x, y, w, h, col, text, value)

    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(29, y, w + 71, h)
	
	surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawRect(30, y + 1, 70, 19)

   
    surface.SetDrawColor(col.r, col.g, col.b, 255)
    surface.DrawRect(x + gap, y + gap, w - gap*2, h - gap*2)   
	
	--local tx, ty = draw.SimpleText(value, "nutNumeric", x + w*.03 + 2, y + h/2 - 1, color_black, 3, 1)
    local tx, ty = draw.SimpleText(value, "NobberFont", x + w*.03, y + h/2 - 2, color_white, 3, 1)
 
    --local ax, ay = draw.SimpleText(L(text), "NobberFont", x + w*.03 + 2 + tx * 1.1, y + h/2 + 2, color_black, 3, 1)
    local ax, ay = draw.SimpleText(L(text), "NobberFont", x + w*.03 + tx * 1.1, y + h/2 - 2, color_white, 3, 1)
 
end

local hp = nut.util.getMaterial("vgui/hp.png")
local armor = nut.util.getMaterial("vgui/Armor.png")
local stamMat = nut.util.getMaterial("vgui/marine.png")
local fade = nut.util.getMaterial("vgui/redbar.png")
 
local aspect = {
    "",
    "",
	"",
}

local aspect2 = {
    function(client) return math.max(0, client:Health()) end,
	function(client) return math.Round(client:getLocalVar("stm", 0)) end,
    function(client) return math.max(0, client:Armor()) end,
	
}

local surface = surface


local Approach = math.Approach

hook.Add("HUDPaint", "40kHUD", function()
    local localPlayer = LocalPlayer()
    local client = localPlayer
    local char = client:getChar()
 
    if (!char) then return end
	
	local w, h = ScrW(), ScrH()
    local margin, height, width  = 1000, h*.02, w*.2
    local posx, posy = margin, h - margin - height
    
	drawBar(100, 10, width, height, Color(169, 0, 0), aspect[1], aspect2[1](client))
 
	posy = 15 + height*1.1
    drawBar(100, posy, width, height, Color(30, 37, 101), aspect[3], aspect2[3](client))
	
	--posy = 45 + height*1.1
   --drawBar(100, posy, width, height, Color(0, 102, 0), aspect[2], aspect2[2](client))
	
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hp )
	surface.DrawTexturedRect( 70, 5, 30, 30)
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( armor )
	surface.DrawTexturedRect( 30, 33, 70, 30)
	
	--surface.SetDrawColor( 255, 255, 255, 255 )
	--surface.SetMaterial( stamMat )
	--surface.DrawTexturedRect( 70, 65, 30, 30)
	

	

	 
end)
hook.Add("Think","40kHUD", function() end)

function nut.bar.drawAll()
    nut.bar.drawAction()
end
