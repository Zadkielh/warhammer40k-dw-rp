local gradient = nut.util.getMaterial("vgui/gradient-r.vtf")
local glow = surface.GetTextureID("particle/Particle_Glow_04_Additive")
local dw = nut.util.getMaterial("vgui/intro_dw.png")

local PANEL = {}
	function PANEL:Init()

		if (IsValid(nut.gui.intro)) then
			nut.gui.intro:Remove()
		end

		nut.gui.intro = self

		self:SetSize(ScrW(), ScrH())
		self:SetZPos(9999)

		timer.Simple(0.1, function()
			if (!IsValid(self)) then
				return
			end

			self.sound = CreateSound(LocalPlayer(), "introscore.mp3")
			self.sound:Play()
			self.sound:ChangePitch(90, 0)
			self.sound:ChangeVolume( 1, 0 )
		end)

		self.authors = self:Add("DLabel")
		self.authors:SetText("Zadkiel and Metro-Networks presents")
		self.authors:SetFont("nutIntroMediumFont")
		self.authors:SetTextColor(color_white)
		self.authors:SetAlpha(0)
		self.authors:AlphaTo(255, 3, 1.5, function()
			self.authors:AlphaTo(0, 3, 1.5, function()
				self.authors:SetText("with big thanks to the NutScript team")
				self.authors:SizeToContents()
				self.authors:CenterHorizontal()

				self.authors:AlphaTo(255, 3, 0.5, function()
					self.authors:AlphaTo(0, 3, 1, function()
						self.authors:SetText("and a massive thank you to Joazzz.")
						self.authors:SizeToContents()
						self.authors:CenterHorizontal()
						
						self.authors:AlphaTo(255, 3, 0.5, function()
							self.authors:AlphaTo(0, 3, 1, function()
						
								self.cover:MoveTo(self.name:GetWide(), 0, 1, 1, nil, function()
									self.glow = true
									self.delta = 0
				
									--self.schema:AlphaTo(255, 5, 1)
								end)
							end)
						end)
					end)
				end)
			end)
		end)
		self.authors:SizeToContents()
		self.authors:Center()
		self.authors:SetZPos(99)

		self.name = self:Add("DLabel")
		self.name:SetText("")
		self.name:SetFont("nutIntroTitleFont")
		self.name:SetTextColor(color_white)
		self.name:SizeToContents()
		self.name:Center()
		self.name:SetPos(self.name.x, ScrH() * 0.4)
		self.name:SetExpensiveShadow(2, color_black)

		self.schema = self:Add("DLabel")
		self.schema:SetText(SCHEMA.introName and L(SCHEMA.introName) or L(SCHEMA.name))
		self.schema:SetFont("nutIntroBigFont")
		self.schema:SizeToContents()
		self.schema:Center()
		self.schema:MoveBelow(self.name, 10)
		self.schema:SetAlpha(0)
		self.schema:SetExpensiveShadow(2, color_black)

		self.cover = self.name:Add("DPanel")
		self.cover:SetSize(ScrW(), self.name:GetTall())
		self.cover.Paint = function(this, w, h)
			surface.SetDrawColor(0, 0, 0)
			surface.SetMaterial(gradient)
			surface.DrawTexturedRect(0, 0, 100, h)

			surface.DrawRect(100, 0, ScrW(), h)
		end
		self.cover:SetPos(-100, 0)

		timer.Simple(20, function()
			if (IsValid(self)) then
				self:addContinue()
			end
		end)
	end

	function PANEL:addContinue()
		self.info = self:Add("DLabel")
		self.info:Dock(BOTTOM)
		self.info:SetTall(36)
		self.info:DockMargin(0, 0, 0, 32)
		self.info:SetText("Press Space to continue...")
		self.info:SetFont("nutIntroSmallFont")
		self.info:SetContentAlignment(2)
		self.info:SetAlpha(0)
		self.info:AlphaTo(255, 1, 0, function()
			self.info.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0.8) * 255))
			end
		end)
		self.info:SetExpensiveShadow(1, color_black)
	end

	function PANEL:Think()
		if (IsValid(self.info) and input.IsKeyDown(KEY_SPACE) and !self.closing) then
			self.closing = true
			self:AlphaTo(0, 2.5, 0, function()
				self:Remove()
			end)
		end
	end

	function PANEL:OnRemove()
		if (self.sound) then
			self.sound:Stop()
			self.sound = nil

			if (IsValid(nut.gui.char)) then
				nut.gui.char:playMusic()
			end
		end
	end

	function PANEL:Paint(w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, w, h)

		if (self.glow) then
			self.delta = math.Approach(self.delta, 100, FrameTime() * 10)

			local x, y = ScrW()*0.5 - 700, ScrH()*0.5 - 340

			surface.SetDrawColor(self.delta + 50, self.delta + 50, self.delta + 50, self.delta + math.sin(RealTime() * 0.7)*20)
			surface.SetMaterial( dw )
			surface.DrawTexturedRect(550, 0, 830, 1080)
			
			
		end
	end
vgui.Register("nutIntro", PANEL, "EditablePanel")


net.Receive( "playIntro", function( len )
vgui.Create("nutIntro")
end) 
