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

		local FrameContinue = vgui.Create( "DFrame" )
		FrameContinue:SetTitle( "" )
		FrameContinue:SetSize( 407, 150 )
		FrameContinue:Center()
		FrameContinue:MakePopup()
		FrameContinue.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 100 ) )
		end

		local DLabel = vgui.Create( "DLabel", FrameContinue)
		DLabel:SetPos( 50, 20 )
		DLabel:SetText( "Continue? You might get an injury or a PK/NPK" )
		DLabel:SetColor( Color( 255, 0, 0 ) )
		DLabel:SetFont( "Trebuchet18" )
		DLabel:SizeToContents()

		local ButtonYes = vgui.Create( "DButton", FrameContinue )
		ButtonYes:SetText( "Yes" )
		ButtonYes:SetTextColor( Color( 255, 255, 255 ) )
		ButtonYes:SetPos( 75, 50)
		ButtonYes:SetSize( 100, 50 )
		ButtonYes.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
		end
		ButtonYes.DoClick = function()
			net.Start( "RespawnActivate" )
			net.SendToServer()
			Frame:Remove()
			FrameContinue:Remove()
		end

		local ButtonNo = vgui.Create( "DButton", FrameContinue )
		ButtonNo:SetText( "No" )
		ButtonNo:SetTextColor( Color( 255, 255, 255 ) )
		ButtonNo:SetPos( 225, 50)
		ButtonNo:SetSize( 100, 50 )
		ButtonNo.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
		end
		ButtonNo.DoClick = function()
			FrameContinue:Remove()
		end
	
	end
end
)
