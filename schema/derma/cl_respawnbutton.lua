net.Receive( "openRespawnMenu", function( len )
local PANEL = {}

	function PANEL:Init()
	local W, H = self:GetParent():GetSize()
		self:SetPos((ScrW()-W)/1.5, (ScrH()-H)/1.5)
		self:SetSize(self:GetParent():GetSize())
	end
	
vgui.Register("respawnButton", PANEL, "DFrame")

	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "" )
	Frame:SetSize( 307, 70 )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 10 ) ) -- Draw a red box instead of the frame
	end

	local Button = vgui.Create( "DButton", Frame )
	Button:SetText( "Respawn" )
	Button:SetTextColor( Color( 255, 255, 255 ) )
	Button:SetPos( 0, 20)
	Button:SetSize( 300, 50 )
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
	end
	Button.DoClick = function()
		net.Start( "RespawnActivate" )
		net.SendToServer()
		Button:Remove()
		Frame:Remove()
	end
	timer.Simple(10, function()
		Button:Remove()
		Frame:Remove()
	end)
end
)
