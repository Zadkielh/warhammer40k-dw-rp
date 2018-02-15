
----== DERMA ==----

-- Remember to use local variables


-- Example from the Gmod Wiki. 

function TechPanel() -- Use functions to call the panel.
	
	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( 5, 5 )
	Frame:SetSize( 300, 150 )
	Frame:SetTitle( "Tech Tree" )
	Frame:SetVisible( true )
	Frame:SetDraggable( false )
	Frame:ShowCloseButton( true )
	Frame:MakePopup()

end


----== VGUI ==----

if SERVER then return end
local PLUGIN = PLUGIN

local PANEL = {}

	function PANEL:Init()
		local W, H = self:GetParent():GetSize()
		self:SetPos((ScrW()-W)/1.5, (ScrH()-H)/1.5)
		self:SetSize(self:GetParent():GetSize())
		self:ShowCloseButton( false)
		self:SetTitle(L"Tech Tree")
		self:CenterHorizontal( 0.8 )
		self:CenterVertical( 0.8 )
		self:MakePopup()
		
		
		local Frame = vgui.Create( "DFrame" )
		Frame:Center()
		Frame:SetSize( 300, 300 )
		Frame:SetTitle( "Physics" )
		Frame:SetVisible( true )
		Frame:SetDraggable( false )
		Frame:ShowCloseButton( true )
		Frame:SetDraggable( true )
		Frame:MakePopup()
		
		Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 231, 150 ) ) -- Draw a red box instead of the frame
		end
		
		local Button = vgui.Create( "DButton", Frame )
			Button:SetText( "Description" )
			Button:SetTextColor( Color( 0, 0, 0 ) )
			Button:SetPos( 100, 100 )
			Button:SetSize( 100, 30 )
			Button.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 205 ) ) -- Draw a blue button
			end
			Button.DoClick = function()
				
			end
		
		local Text = nil
		
		local TextEntry = vgui.Create( "DTextEntry", Frame )
		TextEntry:SetPos( 100, 200 )
		TextEntry:SetSize( 75, 25 )
		TextEntry:SetText( "Enter Text" )
		TextEntry.OnEnter = function( self )
			Text = self:GetValue()
			print( Text )
		end
	end
	
vgui.Register("nut_TechTree", PANEL, "DFrame")