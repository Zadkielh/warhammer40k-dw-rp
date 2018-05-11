include("shared.lua")

function ENT:Draw()

	self:DrawModel() -- Shows the ent model to the client

end

surface.CreateFont( "QuestFont", {
	font = "Roboto-Condensed", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 16,
	weight = 700,
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

surface.CreateFont( "QuestDescFont", {
	font = "Roboto-Condensed", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 23,
	weight = 700,
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
	
net.Receive( "DrawDerma", function (len, pl)
	--Draws the clipboard background
	QBoardBoxCol = Color(109, 109, 109, 0)
	local background = Material( "vgui/questboard/clipboard.png", "noclamp smooth" )
	local aFrame = vgui.Create( "DFrame" )
			aFrame:SetTitle( " " )
			aFrame:SetSize( 600, 600 )
			aFrame:Center()
			aFrame:MakePopup()
			aFrame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial(background) -- If you use Material, cache it!
				surface.DrawTexturedRect( 0, 0, 600, 500 )
			end
-- Begin top row of quest derma
-- BEGIN FIRST BOX SHIT
	local aDPanel = vgui.Create( "DPanel", aFrame )
			aDPanel:SetPos( 12, 40 ) -- Set the position of the panel
			aDPanel:SetSize( 190, 210 ) -- Set the size of the panel
			aDPanel:SetBackgroundColor(QBoardBoxCol)

	local aDLabel = vgui.Create( "DLabel", aDPanel )
			aDLabel:SetPos( 2, 6 ) -- Set the position of the label
			aDLabel:SetFont( "QuestFont" )
			aDLabel:SetText( "Quest Name: "..Quests.Quest1.QuestName.." " ) -- Set the text of the label
			aDLabel:SizeToContents() -- Size the label to fit the text in it

	local a2DLabel = vgui.Create( "DLabel", aDPanel )
			a2DLabel:SetPos( 2, 21 ) -- Set the position of the label
			a2DLabel:SetFont( "QuestFont" )
			a2DLabel:SetText( "Objectives: " ) -- Set the text of the label
			a2DLabel:SizeToContents() -- Size the label to fit the text in it

	local aButton = vgui.Create( "DButton", aDPanel ) // Create the button and parent it to the frame
			aButton:SetText( "Click Me" )					// Set the text on the button
			aButton:SetPos( 80, 24 )					// Set the position on the frame
			aButton:SetSize( 60, 13 )				// Set the size
			aButton.Paint = function()
			surface.SetDrawColor( 234, 152, 0, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, aButton:GetWide(), aButton:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			aButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local bFrame = vgui.Create( "DFrame" )
						bFrame:SetTitle( " " )
						bFrame:SetSize( 600, 600 )
						bFrame:Center()
						bFrame:MakePopup()
						bFrame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial(background) -- If you use Material, cache it!
							surface.DrawTexturedRect( 0, 0, 600, 500 )
						end

				local Obj1 = vgui.Create( "DLabel", bFrame )
						Obj1:SetPos( 17, -289 ) -- Set the position of the panel
						Obj1:SetFont( "QuestDescFont" )
						Obj1:SetText(Quests.Quest1.Obj1)
						Obj1:SetSize( 560, 700 ) -- Set the size of the panel

				local Obj2 = vgui.Create( "DLabel", bFrame )
						Obj2:SetPos( 17, -263 ) -- Set the position of the panel
						Obj2:SetFont( "QuestDescFont" )
						Obj2:SetText(Quests.Quest1.Obj2)
						Obj2:SetSize( 560, 700 ) -- Set the size of the panel

				local Obj3 = vgui.Create( "DLabel", bFrame )
						Obj3:SetPos( 17, -239 ) -- Set the position of the panel
						Obj3:SetFont( "QuestDescFont" )
						Obj3:SetText(Quests.Quest1.Obj3)
						Obj3:SetSize( 560, 700 ) -- Set the size of the panel
			end

	local a3DLabel = vgui.Create( "DLabel", aDPanel )
			a3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			a3DLabel:SetFont( "QuestFont" )
			a3DLabel:SetText( "Quest Status: "..Quests.Quest1.QuestStatus.." " ) -- Set the text of the label
			a3DLabel:SizeToContents() -- Size the label to fit the text in it

	local a4DLabel = vgui.Create( "DLabel", aDPanel )
			a4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			a4DLabel:SetFont( "QuestFont" )
			a4DLabel:SetText( "Given by: "..Quests.Quest1.GivenBy.." " ) -- Set the text of the label
			a4DLabel:SizeToContents() -- Size the label to fit the text in it
-- END FIRST BOX SHIT
-- BEGIN SECOND BOX SHIT
	local bDPanel = vgui.Create( "DPanel", aFrame )
			bDPanel:SetPos( 207, 40 ) -- Set the position of the panel
			bDPanel:SetSize( 190, 210 ) -- Set the size of the panel
			bDPanel:SetBackgroundColor(QBoardBoxCol)

	local bDLabel = vgui.Create( "DLabel", bDPanel )
			bDLabel:SetPos( 2, 6 ) -- Set the position of the label
			bDLabel:SetFont( "QuestFont" )
			bDLabel:SetText( "Quest Name: "..Quests.Quest2.QuestName.." " ) -- Set the text of the label
			bDLabel:SizeToContents() -- Size the label to fit the text in it

	local b2DLabel = vgui.Create( "DLabel", bDPanel )
			b2DLabel:SetPos( 2, 21 ) -- Set the position of the label
			b2DLabel:SetFont( "QuestFont" )
			b2DLabel:SetText( "Objectives: " ) -- Set the text of the label
			b2DLabel:SizeToContents() -- Size the label to fit the text in it
	
	local bButton = vgui.Create( "DButton", bDPanel ) // Create the button and parent it to the frame
			bButton:SetText( "Click Me" )					// Set the text on the button
			bButton:SetPos( 80, 24 )					// Set the position on the frame
			bButton:SetSize( 60, 13 )				// Set the size
			bButton.Paint = function()
			surface.SetDrawColor( 234, 152, 0, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, bButton:GetWide(), bButton:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			bButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local cFrame = vgui.Create( "DFrame" )
						cFrame:SetTitle( " " )
						cFrame:SetSize( 600, 600 )
						cFrame:Center()
						cFrame:MakePopup()
						cFrame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial(background) -- If you use Material, cache it!
							surface.DrawTexturedRect( 0, 0, 600, 500 )
						end

				local Q2Obj1 = vgui.Create( "DLabel", cFrame )
						Q2Obj1:SetPos( 17, -289 ) -- Set the position of the panel
						Q2Obj1:SetFont( "QuestDescFont" )
						Q2Obj1:SetText(Quests.Quest2.Obj1)
						Q2Obj1:SetSize( 560, 700 ) -- Set the size of the panel

				local Q2Obj2 = vgui.Create( "DLabel", cFrame )
						Q2Obj2:SetPos( 17, -263 ) -- Set the position of the panel
						Q2Obj2:SetFont( "QuestDescFont" )
						Q2Obj2:SetText(Quests.Quest2.Obj2)
						Q2Obj2:SetSize( 560, 700 ) -- Set the size of the panel

				local Q2Obj3 = vgui.Create( "DLabel", cFrame )
						Q2Obj3:SetPos( 17, -239 ) -- Set the position of the panel
						Q2Obj3:SetFont( "QuestDescFont" )
						Q2Obj3:SetText(Quests.Quest2.Obj3)
						Q2Obj3:SetSize( 560, 700 ) -- Set the size of the panel
			end
			

	local b3DLabel = vgui.Create( "DLabel", bDPanel )
			b3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			b3DLabel:SetFont( "QuestFont" )
			b3DLabel:SetText( "Quest Status: "..Quests.Quest2.QuestStatus.." " ) -- Set the text of the label
			b3DLabel:SizeToContents() -- Size the label to fit the text in it

	local b4DLabel = vgui.Create( "DLabel", bDPanel )
			b4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			b4DLabel:SetFont( "QuestFont" )
			b4DLabel:SetText( "Given by: "..Quests.Quest2.GivenBy.." " ) -- Set the text of the label
			b4DLabel:SizeToContents() -- Size the label to fit the text in it
-- END SECOND BOX SHIT
-- BEGIN THIRD BOX SHIT
	local cDPanel = vgui.Create( "DPanel", aFrame )
			cDPanel:SetPos( 402, 40 ) -- Set the position of the panel
			cDPanel:SetSize( 186, 210 ) -- Set the size of the panel
			cDPanel:SetBackgroundColor(QBoardBoxCol)

	local cDLabel = vgui.Create( "DLabel", cDPanel )
			cDLabel:SetPos( 2, 6 ) -- Set the position of the label
			cDLabel:SetFont( "QuestFont" )
			cDLabel:SetText( "Quest Name: "..Quests.Quest3.QuestName.." " ) -- Set the text of the label
			cDLabel:SizeToContents() -- Size the label to fit the text in it

	local c2DLabel = vgui.Create( "DLabel", cDPanel )
			c2DLabel:SetPos( 2, 21 ) -- Set the position of the label
			c2DLabel:SetFont( "QuestFont" )
			c2DLabel:SetText( "Objectives: " ) -- Set the text of the label
			c2DLabel:SizeToContents() -- Size the label to fit the text in it

	local cButton = vgui.Create( "DButton", cDPanel ) // Create the button and parent it to the frame
			cButton:SetText( "Click Me" )					// Set the text on the button
			cButton:SetPos( 80, 24 )					// Set the position on the frame
			cButton:SetSize( 60, 13 )				// Set the size
			cButton.Paint = function()
			surface.SetDrawColor( 234, 152, 0, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, cButton:GetWide(), cButton:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			cButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local dFrame = vgui.Create( "DFrame" )
						dFrame:SetTitle( " " )
						dFrame:SetSize( 600, 600 )
						dFrame:Center()
						dFrame:MakePopup()
						dFrame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial(background) -- If you use Material, cache it!
							surface.DrawTexturedRect( 0, 0, 600, 500 )
						end

				local Q3Obj1 = vgui.Create( "DLabel", dFrame )
						Q3Obj1:SetPos( 17, -289 ) -- Set the position of the panel
						Q3Obj1:SetFont( "QuestDescFont" )
						Q3Obj1:SetText(Quests.Quest3.Obj1)
						Q3Obj1:SetSize( 560, 700 ) -- Set the size of the panel

				local Q3Obj2 = vgui.Create( "DLabel", dFrame )
						Q3Obj2:SetPos( 17, -263 ) -- Set the position of the panel
						Q3Obj2:SetFont( "QuestDescFont" )
						Q3Obj2:SetText(Quests.Quest3.Obj2)
						Q3Obj2:SetSize( 560, 700 ) -- Set the size of the panel

				local Q3Obj3 = vgui.Create( "DLabel", dFrame )
						Q3Obj3:SetPos( 17, -239 ) -- Set the position of the panel
						Q3Obj3:SetFont( "QuestDescFont" )
						Q3Obj3:SetText(Quests.Quest3.Obj3)
						Q3Obj3:SetSize( 560, 700 ) -- Set the size of the panel
			end

	local c3DLabel = vgui.Create( "DLabel", cDPanel )
			c3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			c3DLabel:SetFont( "QuestFont" )
			c3DLabel:SetText( "Quest Status: "..Quests.Quest3.QuestStatus.." " ) -- Set the text of the label
			c3DLabel:SizeToContents() -- Size the label to fit the text in it

	local c4DLabel = vgui.Create( "DLabel", cDPanel )
			c4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			c4DLabel:SetFont( "QuestFont" )
			c4DLabel:SetText( "Given by: "..Quests.Quest3.GivenBy.." " ) -- Set the text of the label
			c4DLabel:SizeToContents() -- Size the label to fit the text in it
-- END THIRD BOX SHIT
-- End top row of quest derma


--BEGIN BOTTOM ROW DERMA
local dDPanel = vgui.Create( "DPanel", aFrame )
			dDPanel:SetPos( 12, 260 ) -- Set the position of the panel
			dDPanel:SetSize( 190, 210 ) -- Set the size of the panel
			dDPanel:SetBackgroundColor(QBoardBoxCol)

	local dDLabel = vgui.Create( "DLabel", dDPanel )
			dDLabel:SetPos( 2, 6 ) -- Set the position of the label
			dDLabel:SetFont( "QuestFont" )
			dDLabel:SetText( "Quest Name: "..Quests.Quest4.QuestName.." " ) -- Set the text of the label
			dDLabel:SizeToContents() -- Size the label to fit the text in it

	local d2DLabel = vgui.Create( "DLabel", dDPanel )
			d2DLabel:SetPos( 2, 21 ) -- Set the position of the label
			d2DLabel:SetFont( "QuestFont" )
			d2DLabel:SetText( "Objectives: " ) -- Set the text of the label
			d2DLabel:SizeToContents() -- Size the label to fit the text in it

	local dButton = vgui.Create( "DButton", dDPanel ) // Create the button and parent it to the frame
			dButton:SetText( "Click Me" )					// Set the text on the button
			dButton:SetPos( 80, 24 )					// Set the position on the frame
			dButton:SetSize( 60, 13 )				// Set the size
			dButton.Paint = function()
			surface.SetDrawColor( 234, 152, 0, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, dButton:GetWide(), dButton:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			dButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local eFrame = vgui.Create( "DFrame" )
						eFrame:SetTitle( " " )
						eFrame:SetSize( 600, 600 )
						eFrame:Center()
						eFrame:MakePopup()
						eFrame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial(background) -- If you use Material, cache it!
							surface.DrawTexturedRect( 0, 0, 600, 500 )
						end

				local Q4Obj1 = vgui.Create( "DLabel", eFrame )
						Q4Obj1:SetPos( 17, -289 ) -- Set the position of the panel
						Q4Obj1:SetFont( "QuestDescFont" )
						Q4Obj1:SetText(Quests.Quest4.Obj1)
						Q4Obj1:SetSize( 560, 700 ) -- Set the size of the panel

				local Q4Obj2 = vgui.Create( "DLabel", eFrame )
						Q4Obj2:SetPos( 17, -263 ) -- Set the position of the panel
						Q4Obj2:SetFont( "QuestDescFont" )
						Q4Obj2:SetText(Quests.Quest4.Obj2)
						Q4Obj2:SetSize( 560, 700 ) -- Set the size of the panel

				local Q4Obj3 = vgui.Create( "DLabel", eFrame )
						Q4Obj3:SetPos( 17, -239 ) -- Set the position of the panel
						Q4Obj3:SetFont( "QuestDescFont" )
						Q4Obj3:SetText(Quests.Quest4.Obj3)
						Q4Obj3:SetSize( 560, 700 ) -- Set the size of the panel
			end

	local d3DLabel = vgui.Create( "DLabel", dDPanel )
			d3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			d3DLabel:SetFont( "QuestFont" )
			d3DLabel:SetText( "Quest Status: "..Quests.Quest4.QuestStatus.." " ) -- Set the text of the label
			d3DLabel:SizeToContents() -- Size the label to fit the text in it

	local d4DLabel = vgui.Create( "DLabel", dDPanel )
			d4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			d4DLabel:SetFont( "QuestFont" )
			d4DLabel:SetText( "Given by: "..Quests.Quest4.GivenBy.." " ) -- Set the text of the label
			d4DLabel:SizeToContents() -- Size the label to fit the text in it
-- END FIRST BOX SHIT
-- BEGIN SECOND BOX SHIT
	local eDPanel = vgui.Create( "DPanel", aFrame )
			eDPanel:SetPos( 207, 260 ) -- Set the position of the panel
			eDPanel:SetSize( 190, 210 ) -- Set the size of the panel
			eDPanel:SetBackgroundColor(QBoardBoxCol)

	local eDLabel = vgui.Create( "DLabel", eDPanel )
			eDLabel:SetPos( 2, 6 ) -- Set the position of the label
			eDLabel:SetFont( "QuestFont" )
			eDLabel:SetText( "Quest Name: "..Quests.Quest5.QuestName.." " ) -- Set the text of the label
			eDLabel:SizeToContents() -- Size the label to fit the text in it

	local e2DLabel = vgui.Create( "DLabel", eDPanel )
			e2DLabel:SetPos( 2, 21 ) -- Set the position of the label
			e2DLabel:SetFont( "QuestFont" )
			e2DLabel:SetText( "Objectives: " ) -- Set the text of the label
			e2DLabel:SizeToContents() -- Size the label to fit the text in it

	local eButton = vgui.Create( "DButton", eDPanel ) // Create the button and parent it to the frame
			eButton:SetText( "Click Me" )					// Set the text on the button
			eButton:SetPos( 80, 24 )					// Set the position on the frame
			eButton:SetSize( 60, 13 )				// Set the size
			eButton.Paint = function()
			surface.SetDrawColor( 234, 152, 0, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, eButton:GetWide(), eButton:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			eButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local fFrame = vgui.Create( "DFrame" )
						fFrame:SetTitle( " " )
						fFrame:SetSize( 600, 600 )
						fFrame:Center()
						fFrame:MakePopup()
						fFrame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial(background) -- If you use Material, cache it!
							surface.DrawTexturedRect( 0, 0, 600, 500 )
						end
						
				local Q5Obj1 = vgui.Create( "DLabel", fFrame )
						Q5Obj1:SetPos( 17, -289 ) -- Set the position of the panel
						Q5Obj1:SetFont( "QuestDescFont" )
						Q5Obj1:SetText(Quests.Quest5.Obj1)
						Q5Obj1:SetSize( 560, 700 ) -- Set the size of the panel

				local Q5Obj2 = vgui.Create( "DLabel", fFrame )
						Q5Obj2:SetPos( 17, -263 ) -- Set the position of the panel
						Q5Obj2:SetFont( "QuestDescFont" )
						Q5Obj2:SetText(Quests.Quest5.Obj2)
						Q5Obj2:SetSize( 560, 700 ) -- Set the size of the panel

				local Q5Obj3 = vgui.Create( "DLabel", fFrame )
						Q5Obj3:SetPos( 17, -239 ) -- Set the position of the panel
						Q5Obj3:SetFont( "QuestDescFont" )
						Q5Obj3:SetText(Quests.Quest5.Obj3)
						Q5Obj3:SetSize( 560, 700 ) -- Set the size of the panel
			end

	local e3DLabel = vgui.Create( "DLabel", eDPanel )
			e3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			e3DLabel:SetFont( "QuestFont" )
			e3DLabel:SetText( "Quest Status: "..Quests.Quest5.QuestStatus.." " ) -- Set the text of the label
			e3DLabel:SizeToContents() -- Size the label to fit the text in it

	local e4DLabel = vgui.Create( "DLabel", eDPanel )
			e4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			e4DLabel:SetFont( "QuestFont" )
			e4DLabel:SetText( "Given by: "..Quests.Quest5.GivenBy.." " ) -- Set the text of the label
			e4DLabel:SizeToContents() -- Size the label to fit the text in it
-- END SECOND BOX SHIT
-- BEGIN THIRD BOX SHIT
	local fDPanel = vgui.Create( "DPanel", aFrame )
			fDPanel:SetPos( 402, 260 ) -- Set the position of the panel
			fDPanel:SetSize( 186, 210 ) -- Set the size of the panel
			fDPanel:SetBackgroundColor(QBoardBoxCol)

	local fDLabel = vgui.Create( "DLabel", fDPanel )
			fDLabel:SetPos( 2, 6 ) -- Set the position of the label
			fDLabel:SetFont( "QuestFont" )
			fDLabel:SetText( "Quest Name: "..Quests.Quest6.QuestName.." " ) -- Set the text of the label
			fDLabel:SizeToContents() -- Size the label to fit the text in it

	local f2DLabel = vgui.Create( "DLabel", fDPanel )
			f2DLabel:SetPos( 2, 21 ) -- Set the position of the label
			f2DLabel:SetFont( "QuestFont" )
			f2DLabel:SetText( "Objectives: " ) -- Set the text of the label
			f2DLabel:SizeToContents() -- Size the label to fit the text in it

	local fButton = vgui.Create( "DButton", fDPanel ) // Create the button and parent it to the frame
			fButton:SetText( "Click Me" )					// Set the text on the button
			fButton:SetPos( 80, 24 )					// Set the position on the frame
			fButton:SetSize( 60, 13 )				// Set the size
			fButton.Paint = function()
			surface.SetDrawColor( 234, 152, 0, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, fButton:GetWide(), fButton:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			fButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local gFrame = vgui.Create( "DFrame" )
						gFrame:SetTitle( " " )
						gFrame:SetSize( 600, 600 )
						gFrame:Center()
						gFrame:MakePopup()
						gFrame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial(background) -- If you use Material, cache it!
							surface.DrawTexturedRect( 0, 0, 600, 500 )
						end
				
				local Q6Obj1 = vgui.Create( "DLabel", gFrame )
						Q6Obj1:SetPos( 17, -289 ) -- Set the position of the panel
						Q6Obj1:SetFont( "QuestDescFont" )
						Q6Obj1:SetText(Quests.Quest6.Obj1)
						Q6Obj1:SetSize( 560, 700 ) -- Set the size of the panel

				local Q6Obj2 = vgui.Create( "DLabel", gFrame )
						Q6Obj2:SetPos( 17, -263 ) -- Set the position of the panel
						Q6Obj2:SetFont( "QuestDescFont" )
						Q6Obj2:SetText(Quests.Quest6.Obj2)
						Q6Obj2:SetSize( 560, 700 ) -- Set the size of the panel

				local Q6Obj3 = vgui.Create( "DLabel", gFrame )
						Q6Obj3:SetPos( 17, -239 ) -- Set the position of the panel
						Q6Obj3:SetFont( "QuestDescFont" )
						Q6Obj3:SetText(Quests.Quest6.Obj3)
						Q6Obj3:SetSize( 560, 700 ) -- Set the size of the panel
			end

	local f3DLabel = vgui.Create( "DLabel", fDPanel )
			f3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			f3DLabel:SetFont( "QuestFont" )
			f3DLabel:SetText( "Quest Status: "..Quests.Quest6.QuestStatus.." " ) -- Set the text of the label
			f3DLabel:SizeToContents() -- Size the label to fit the text in it

	local f4DLabel = vgui.Create( "DLabel", fDPanel )
			f4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			f4DLabel:SetFont( "QuestFont" )
			f4DLabel:SetText( "Given by: "..Quests.Quest6.GivenBy.." " ) -- Set the text of the label
			f4DLabel:SizeToContents() -- Size the label to fit the text in it
-- END THIRD BOX SHIT
-- End top row of quest derma
 end )