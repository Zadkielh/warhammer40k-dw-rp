netstream.Hook( "ReceiveQuestVar", function( identifier, varKey, value )

    Quests["Quest"..identifier][varKey] = value;

end );

concommand.Add( "addquest", function( ply, cmd, args )

	if ply:IsSuperAdmin() or ply:IsAdmin() then

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
	
	--Draws the clipboard background
	local QBoardBoxCol = Color(109, 109, 109, 0)
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
			aDLabel:SetText( "Quest Name: " ) -- Set the text of the label
			aDLabel:SizeToContents() -- Size the label to fit the text in it

	local QuestName = vgui.Create( "DTextEntry", aDPanel ) -- create the form as a child of frame
			QuestName:SetPos( 85, 9 )
			QuestName:SetSize( 89, 12 )
			QuestName:SetText( "" )
			QuestName.OnEnter = function( self )
				netstream.Start( "ChangeQuestVar", 1, "QuestName", self:GetValue() )
				sound.PlayFile( "sound/vgui/ui_levelup.mp3", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end
				

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

				local Quest1Obj1 = vgui.Create( "DTextEntry", bFrame)
						Quest1Obj1:SetPos(18, 30)
						Quest1Obj1:SetSize(340, 24)
						Quest1Obj1:SetText("•")
						Quest1Obj1.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 1, "Obj1", self:GetValue() )
						end

				local Quest1Obj2 = vgui.Create( "DTextEntry", bFrame)
						Quest1Obj2:SetPos(18, 70)
						Quest1Obj2:SetSize(340, 24)
						Quest1Obj2:SetText("•")
						Quest1Obj2.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 1, "Obj2", self:GetValue() )
						end

				local Quest1Obj3 = vgui.Create( "DTextEntry", bFrame)
						Quest1Obj3:SetPos(18, 110)
						Quest1Obj3:SetSize(340, 24)
						Quest1Obj3:SetText("•")
						Quest1Obj3.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 1, "Obj3", self:GetValue() )
						end
			end

			local a3DLabel = vgui.Create( "DLabel", aDPanel )
			a3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			a3DLabel:SetFont( "QuestFont" )
			a3DLabel:SetText( "Quest Status: "..Quests.Quest1.QuestStatus.." " ) -- Set the text of the label
			a3DLabel:SizeToContents() -- Size the label to fit the text in it

			local StartQuest = vgui.Create( "DButton", aDPanel ) // Create the button and parent it to the frame
			StartQuest:SetText( "Start Quest" )					// Set the text on the button
			StartQuest:SetPos( 65, 70 )					// Set the position on the frame
			StartQuest:SetSize( 70, 35 )				// Set the size
			StartQuest.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, StartQuest:GetWide(), StartQuest:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			StartQuest.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 1, "QuestStatus", "Started" )
				sound.PlayFile( "sound/vgui/queststart.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
				local self = LocalPlayer()
				netstream.Start( "ChangeQuestVar", 1, "GivenBy", self:Nick() )
			end

			local EndQuest = vgui.Create( "DButton", aDPanel ) // Create the button and parent it to the frame
			EndQuest:SetText( "End Quest" )					// Set the text on the button
			EndQuest:SetPos( 65, 120 )					// Set the position on the frame
			EndQuest:SetSize( 70, 35 )				// Set the size
			EndQuest.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, EndQuest:GetWide(), EndQuest:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			EndQuest.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 1, "QuestStatus", "Completed" )
				sound.PlayFile( "sound/vgui/questend.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

			local a4DLabel = vgui.Create( "DLabel", aDPanel )
			a4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			a4DLabel:SetFont( "QuestFont" )
			a4DLabel:SetText( "Given by: "..Quests.Quest1.GivenBy.." " ) -- Set the text of the label
			a4DLabel:SizeToContents() -- Size the label to fit the text in it

---------------------------------------------------------------------------------------------------------------------------

	local bDPanel = vgui.Create( "DPanel", aFrame )
			bDPanel:SetPos( 207, 40 ) -- Set the position of the panel
			bDPanel:SetSize( 190, 210 ) -- Set the size of the panel
			bDPanel:SetBackgroundColor(QBoardBoxCol)

	local bDLabel = vgui.Create( "DLabel", bDPanel )
			bDLabel:SetPos( 2, 6 ) -- Set the position of the label
			bDLabel:SetFont( "QuestFont" )
			bDLabel:SetText( "Quest Name: "..Quests.Quest2.QuestName.." " ) -- Set the text of the label
			bDLabel:SizeToContents() -- Size the label to fit the text in it

	local QuestName2 = vgui.Create( "DTextEntry", bDPanel ) -- create the form as a child of frame
			QuestName2:SetPos( 85, 9 )
			QuestName2:SetSize( 89, 12 )
			QuestName2:SetText( "" )
			QuestName2.OnEnter = function( self )
				netstream.Start( "ChangeQuestVar", 2, "QuestName", self:GetValue() )
				sound.PlayFile( "sound/vgui/ui_levelup.mp3", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

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

				local Quest2Obj1 = vgui.Create( "DTextEntry", cFrame)
						Quest2Obj1:SetPos(18, 30)
						Quest2Obj1:SetSize(340, 24)
						Quest2Obj1:SetText("•")
						Quest2Obj1.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 2, "Obj1", self:GetValue() )
						end

				local Quest2Obj2 = vgui.Create( "DTextEntry", cFrame)
						Quest2Obj2:SetPos(18, 70)
						Quest2Obj2:SetSize(340, 24)
						Quest2Obj2:SetText("•")
						Quest2Obj2.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 2, "Obj2", self:GetValue() )
						end

				local Quest2Obj3 = vgui.Create( "DTextEntry", cFrame)
						Quest2Obj3:SetPos(18, 110)
						Quest2Obj3:SetSize(340, 24)
						Quest2Obj3:SetText("•")
						Quest2Obj3.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 2, "Obj3", self:GetValue() )
						end
			end
			

	local b3DLabel = vgui.Create( "DLabel", bDPanel )
			b3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			b3DLabel:SetFont( "QuestFont" )
			b3DLabel:SetText( "Quest Status: "..Quests.Quest2.QuestStatus.." " ) -- Set the text of the label
			b3DLabel:SizeToContents() -- Size the label to fit the text in it

	local StartQuest2 = vgui.Create( "DButton", bDPanel ) // Create the button and parent it to the frame
			StartQuest2:SetText( "Start Quest" )					// Set the text on the button
			StartQuest2:SetPos( 65, 70 )					// Set the position on the frame
			StartQuest2:SetSize( 70, 35 )				// Set the size
			StartQuest2.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, StartQuest2:GetWide(), StartQuest2:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			StartQuest2.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 2, "QuestStatus", "Started" )
				sound.PlayFile( "sound/vgui/queststart.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
				local self = LocalPlayer()
				netstream.Start( "ChangeQuestVar", 2, "GivenBy", self:Nick() )
			end

	local EndQuest2 = vgui.Create( "DButton", bDPanel ) // Create the button and parent it to the frame
			EndQuest2:SetText( "End Quest" )					// Set the text on the button
			EndQuest2:SetPos( 65, 120 )					// Set the position on the frame
			EndQuest2:SetSize( 70, 35 )				// Set the size
			EndQuest2.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, EndQuest2:GetWide(), EndQuest2:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			EndQuest2.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 2, "QuestStatus", "Completed" )
				sound.PlayFile( "sound/vgui/questend.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

	local b4DLabel = vgui.Create( "DLabel", bDPanel )
			b4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			b4DLabel:SetFont( "QuestFont" )
			b4DLabel:SetText( "Given by: "..Quests.Quest2.GivenBy.." " ) -- Set the text of the label
			b4DLabel:SizeToContents() -- Size the label to fit the text in it

------------------------------------------------------------------------------------------------------------------------------------------------

	local cDPanel = vgui.Create( "DPanel", aFrame )
			cDPanel:SetPos( 402, 40 ) -- Set the position of the panel
			cDPanel:SetSize( 186, 210 ) -- Set the size of the panel
			cDPanel:SetBackgroundColor(QBoardBoxCol)

	local cDLabel = vgui.Create( "DLabel", cDPanel )
			cDLabel:SetPos( 2, 6 ) -- Set the position of the label
			cDLabel:SetFont( "QuestFont" )
			cDLabel:SetText( "Quest Name: "..Quests.Quest3.QuestName.." " ) -- Set the text of the label
			cDLabel:SizeToContents() -- Size the label to fit the text in it

	local QuestName3 = vgui.Create( "DTextEntry", cDPanel ) -- create the form as a child of frame
			QuestName3:SetPos( 85, 9 )
			QuestName3:SetSize( 89, 12 )
			QuestName3:SetText( "" )
			QuestName3.OnEnter = function( self )
				netstream.Start( "ChangeQuestVar", 3, "QuestName", self:GetValue() )
				sound.PlayFile( "sound/vgui/ui_levelup.mp3", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

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

				local Quest3Obj1 = vgui.Create( "DTextEntry", dFrame)
						Quest3Obj1:SetPos(18, 30)
						Quest3Obj1:SetSize(340, 24)
						Quest3Obj1:SetText("•")
						Quest3Obj1.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 3, "Obj1", self:GetValue() )
						end

				local Quest3Obj2 = vgui.Create( "DTextEntry", dFrame)
						Quest3Obj2:SetPos(18, 70)
						Quest3Obj2:SetSize(340, 24)
						Quest3Obj2:SetText("•")
						Quest3Obj2.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 3, "Obj2", self:GetValue() )
						end

				local Quest3Obj3 = vgui.Create( "DTextEntry", dFrame)
						Quest3Obj3:SetPos(18, 110)
						Quest3Obj3:SetSize(340, 24)
						Quest3Obj3:SetText("•")
						Quest3Obj3.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 3, "Obj3", self:GetValue() )
						end
			end

	local c3DLabel = vgui.Create( "DLabel", cDPanel )
			c3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			c3DLabel:SetFont( "QuestFont" )
			c3DLabel:SetText( "Quest Status: "..Quests.Quest3.QuestStatus.." " ) -- Set the text of the label
			c3DLabel:SizeToContents() -- Size the label to fit the text in it

	local StartQuest3 = vgui.Create( "DButton", cDPanel ) // Create the button and parent it to the frame
			StartQuest3:SetText( "Start Quest" )					// Set the text on the button
			StartQuest3:SetPos( 65, 70 )					// Set the position on the frame
			StartQuest3:SetSize( 70, 35 )				// Set the size
			StartQuest3.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, StartQuest3:GetWide(), StartQuest3:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			StartQuest3.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local self = LocalPlayer()
				netstream.Start( "ChangeQuestVar", 3, "QuestStatus", "Started" )
				sound.PlayFile( "sound/vgui/queststart.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
				netstream.Start( "ChangeQuestVar", 3, "GivenBy", self:Nick() )
			end

	local EndQuest3 = vgui.Create( "DButton", cDPanel ) // Create the button and parent it to the frame
			EndQuest3:SetText( "End Quest" )					// Set the text on the button
			EndQuest3:SetPos( 65, 120 )					// Set the position on the frame
			EndQuest3:SetSize( 70, 35 )				// Set the size
			EndQuest3.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, EndQuest3:GetWide(), EndQuest3:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			EndQuest3.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 3, "QuestStatus", "Completed" )
				sound.PlayFile( "sound/vgui/questend.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

	local c4DLabel = vgui.Create( "DLabel", cDPanel )
			c4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			c4DLabel:SetFont( "QuestFont" )
			c4DLabel:SetText( "Given by: "..Quests.Quest3.GivenBy.." " ) -- Set the text of the label
			c4DLabel:SizeToContents() -- Size the label to fit the text in it

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local dDPanel = vgui.Create( "DPanel", aFrame )
			dDPanel:SetPos( 12, 260 ) -- Set the position of the panel
			dDPanel:SetSize( 190, 210 ) -- Set the size of the panel
			dDPanel:SetBackgroundColor(QBoardBoxCol)

	local dDLabel = vgui.Create( "DLabel", dDPanel )
			dDLabel:SetPos( 2, 6 ) -- Set the position of the label
			dDLabel:SetFont( "QuestFont" )
			dDLabel:SetText( "Quest Name: "..Quests.Quest4.QuestName.." " ) -- Set the text of the label
			dDLabel:SizeToContents() -- Size the label to fit the text in it

	local QuestName4 = vgui.Create( "DTextEntry", dDPanel ) -- create the form as a child of frame
			QuestName4:SetPos( 85, 9 )
			QuestName4:SetSize( 89, 12 )
			QuestName4:SetText( "" )
			QuestName4.OnEnter = function( self )
				netstream.Start( "ChangeQuestVar", 4, "QuestName", self:GetValue() )
				sound.PlayFile( "sound/vgui/ui_levelup.mp3", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

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

				local Quest4Obj1 = vgui.Create( "DTextEntry", eFrame)
						Quest4Obj1:SetPos(18, 30)
						Quest4Obj1:SetSize(340, 24)
						Quest4Obj1:SetText("•")
						Quest4Obj1.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 4, "Obj1", self:GetValue() )
						end

				local Quest4Obj2 = vgui.Create( "DTextEntry", eFrame)
						Quest4Obj2:SetPos(18, 70)
						Quest4Obj2:SetSize(340, 24)
						Quest4Obj2:SetText("•")
						Quest4Obj2.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 4, "Obj2", self:GetValue() )
						end

				local Quest4Obj3 = vgui.Create( "DTextEntry", eFrame)
						Quest4Obj3:SetPos(18, 110)
						Quest4Obj3:SetSize(340, 24)
						Quest4Obj3:SetText("•")
						Quest4Obj3.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 4, "Obj3", self:GetValue() )
						end
			end

	local d3DLabel = vgui.Create( "DLabel", dDPanel )
			d3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			d3DLabel:SetFont( "QuestFont" )
			d3DLabel:SetText( "Quest Status: "..Quests.Quest4.QuestStatus.." " ) -- Set the text of the label
			d3DLabel:SizeToContents() -- Size the label to fit the text in it

	local StartQuest4 = vgui.Create( "DButton", dDPanel ) // Create the button and parent it to the frame
			StartQuest4:SetText( "Start Quest" )					// Set the text on the button
			StartQuest4:SetPos( 65, 70 )					// Set the position on the frame
			StartQuest4:SetSize( 70, 35 )				// Set the size
			StartQuest4.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, StartQuest4:GetWide(), StartQuest4:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			StartQuest4.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local self = LocalPlayer()
				netstream.Start( "ChangeQuestVar", 4, "QuestStatus", "Started" )
				sound.PlayFile( "sound/vgui/queststart.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
				netstream.Start( "ChangeQuestVar", 4, "GivenBy", self:Nick() )
			end

	local EndQuest4 = vgui.Create( "DButton", dDPanel ) // Create the button and parent it to the frame
			EndQuest4:SetText( "End Quest" )					// Set the text on the button
			EndQuest4:SetPos( 65, 120 )					// Set the position on the frame
			EndQuest4:SetSize( 70, 35 )				// Set the size
			EndQuest4.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, EndQuest4:GetWide(), EndQuest4:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			EndQuest4.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 4, "QuestStatus", "Completed" )
				sound.PlayFile( "sound/vgui/questend.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

	local d4DLabel = vgui.Create( "DLabel", dDPanel )
			d4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			d4DLabel:SetFont( "QuestFont" )
			d4DLabel:SetText( "Given by: "..Quests.Quest4.GivenBy.." " ) -- Set the text of the label
			d4DLabel:SizeToContents() -- Size the label to fit the text in it

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local eDPanel = vgui.Create( "DPanel", aFrame )
			eDPanel:SetPos( 207, 260 ) -- Set the position of the panel
			eDPanel:SetSize( 190, 210 ) -- Set the size of the panel
			eDPanel:SetBackgroundColor(QBoardBoxCol)

	local eDLabel = vgui.Create( "DLabel", eDPanel )
			eDLabel:SetPos( 2, 6 ) -- Set the position of the label
			eDLabel:SetFont( "QuestFont" )
			eDLabel:SetText( "Quest Name: "..Quests.Quest5.QuestName.." " ) -- Set the text of the label
			eDLabel:SizeToContents() -- Size the label to fit the text in it

	local QuestName5 = vgui.Create( "DTextEntry", eDPanel ) -- create the form as a child of frame
			QuestName5:SetPos( 85, 9 )
			QuestName5:SetSize( 89, 12 )
			QuestName5:SetText( "" )
			QuestName5.OnEnter = function( self )
				netstream.Start( "ChangeQuestVar", 5, "QuestName", self:GetValue() )
				sound.PlayFile( "sound/vgui/ui_levelup.mp3", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

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

				local Quest5Obj1 = vgui.Create( "DTextEntry", fFrame)
						Quest5Obj1:SetPos(18, 30)
						Quest5Obj1:SetSize(340, 24)
						Quest5Obj1:SetText("•")
						Quest5Obj1.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 5, "Obj1", self:GetValue() )
						end

				local Quest5Obj2 = vgui.Create( "DTextEntry", fFrame)
						Quest5Obj2:SetPos(18, 70)
						Quest5Obj2:SetSize(340, 24)
						Quest5Obj2:SetText("•")
						Quest5Obj2.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 5, "Obj2", self:GetValue() )
						end

				local Quest5Obj3 = vgui.Create( "DTextEntry", fFrame)
						Quest5Obj3:SetPos(18, 110)
						Quest5Obj3:SetSize(340, 24)
						Quest5Obj3:SetText("•")
						Quest5Obj3.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 5, "Obj3", self:GetValue() )
						end
			end

	local e3DLabel = vgui.Create( "DLabel", eDPanel )
			e3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			e3DLabel:SetFont( "QuestFont" )
			e3DLabel:SetText( "Quest Status: "..Quests.Quest5.QuestStatus.." " ) -- Set the text of the label
			e3DLabel:SizeToContents() -- Size the label to fit the text in it

	local StartQuest5 = vgui.Create( "DButton", eDPanel ) // Create the button and parent it to the frame
			StartQuest5:SetText( "Start Quest" )					// Set the text on the button
			StartQuest5:SetPos( 65, 70 )					// Set the position on the frame
			StartQuest5:SetSize( 70, 35 )				// Set the size
			StartQuest5.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, StartQuest5:GetWide(), StartQuest5:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			StartQuest5.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local self = LocalPlayer()
				netstream.Start( "ChangeQuestVar", 5, "QuestStatus", "Started" )
				sound.PlayFile( "sound/vgui/queststart.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
				netstream.Start( "ChangeQuestVar", 5, "GivenBy", self:Nick() )
			end

	local EndQuest5 = vgui.Create( "DButton", eDPanel ) // Create the button and parent it to the frame
			EndQuest5:SetText( "End Quest" )					// Set the text on the button
			EndQuest5:SetPos( 65, 120 )					// Set the position on the frame
			EndQuest5:SetSize( 70, 35 )				// Set the size
			EndQuest5.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, EndQuest5:GetWide(), EndQuest5:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			EndQuest5.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 5, "QuestStatus", "Completed" )
				sound.PlayFile( "sound/vgui/questend.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

	local e4DLabel = vgui.Create( "DLabel", eDPanel )
			e4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			e4DLabel:SetFont( "QuestFont" )
			e4DLabel:SetText( "Given by: "..Quests.Quest5.GivenBy.." " ) -- Set the text of the label
			e4DLabel:SizeToContents() -- Size the label to fit the text in it

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local fDPanel = vgui.Create( "DPanel", aFrame )
			fDPanel:SetPos( 402, 260 ) -- Set the position of the panel
			fDPanel:SetSize( 186, 210 ) -- Set the size of the panel
			fDPanel:SetBackgroundColor(QBoardBoxCol)

	local fDLabel = vgui.Create( "DLabel", fDPanel )
			fDLabel:SetPos( 2, 6 ) -- Set the position of the label
			fDLabel:SetFont( "QuestFont" )
			fDLabel:SetText( "Quest Name: "..Quests.Quest6.QuestName.." " ) -- Set the text of the label
			fDLabel:SizeToContents() -- Size the label to fit the text in it

	local QuestName6 = vgui.Create( "DTextEntry", fDPanel ) -- create the form as a child of frame
			QuestName6:SetPos( 85, 9 )
			QuestName6:SetSize( 89, 12 )
			QuestName6:SetText( "" )
			QuestName6.OnEnter = function( self )
				netstream.Start( "ChangeQuestVar", 6, "QuestName", self:GetValue() )
				sound.PlayFile( "sound/vgui/ui_levelup.mp3", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

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

				local Quest6Obj1 = vgui.Create( "DTextEntry", gFrame)
						Quest6Obj1:SetPos(18, 30)
						Quest6Obj1:SetSize(340, 24)
						Quest6Obj1:SetText("•")
						Quest6Obj1.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 6, "Obj1", self:GetValue() )
						end

				local Quest6Obj2 = vgui.Create( "DTextEntry", gFrame)
						Quest6Obj2:SetPos(18, 70)
						Quest6Obj2:SetSize(340, 24)
						Quest6Obj2:SetText("•")
						Quest6Obj2.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 6, "Obj2", self:GetValue() )
						end

				local Quest6Obj3 = vgui.Create( "DTextEntry", gFrame)
						Quest6Obj3:SetPos(18, 110)
						Quest6Obj3:SetSize(340, 24)
						Quest6Obj3:SetText("•")
						Quest6Obj3.OnEnter = function( self )
							netstream.Start( "ChangeQuestVar", 6, "Obj3", self:GetValue() )
						end
			end

	local f3DLabel = vgui.Create( "DLabel", fDPanel )
			f3DLabel:SetPos( 2, 35 ) -- Set the position of the label
			f3DLabel:SetFont( "QuestFont" )
			f3DLabel:SetText( "Quest Status: "..Quests.Quest6.QuestStatus.." " ) -- Set the text of the label
			f3DLabel:SizeToContents() -- Size the label to fit the text in it

	local StartQuest6 = vgui.Create( "DButton", fDPanel ) // Create the button and parent it to the frame
			StartQuest6:SetText( "Start Quest" )					// Set the text on the button
			StartQuest6:SetPos( 65, 70 )					// Set the position on the frame
			StartQuest6:SetSize( 70, 35 )				// Set the size
			StartQuest6.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, StartQuest6:GetWide(), StartQuest6:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			StartQuest6.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				local self = LocalPlayer()
				netstream.Start( "ChangeQuestVar", 6, "QuestStatus", "Started" )
				sound.PlayFile( "sound/vgui/queststart.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
				netstream.Start( "ChangeQuestVar", 6, "GivenBy", self:Nick() )
			end

	local EndQuest6 = vgui.Create( "DButton", fDPanel ) // Create the button and parent it to the frame
			EndQuest6:SetText( "End Quest" )					// Set the text on the button
			EndQuest6:SetPos( 65, 120 )					// Set the position on the frame
			EndQuest6:SetSize( 70, 35 )				// Set the size
			EndQuest6.Paint = function()
			surface.SetDrawColor( 196, 196, 196, 255 ) -- What color do You want to paint the button (R, B, G, A)
    		surface.DrawRect( 0, 0, EndQuest6:GetWide(), EndQuest6:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			EndQuest6.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
				netstream.Start( "ChangeQuestVar", 6, "QuestStatus", "Completed" )
				sound.PlayFile( "sound/vgui/questend.wav", "", function( ping )
					if ( IsValid( ping ) ) then ping:Play() end
				end )
			end

	local f4DLabel = vgui.Create( "DLabel", fDPanel )
			f4DLabel:SetPos( 2, 180 ) -- Set the position of the label
			f4DLabel:SetFont( "QuestFont" )
			f4DLabel:SetText( "Given by: "..Quests.Quest6.GivenBy.." " ) -- Set the text of the label
			f4DLabel:SizeToContents() -- Size the label to fit the text in it

	else print("You do not have the correct rank to use the admin quest menu!")
	end
end)