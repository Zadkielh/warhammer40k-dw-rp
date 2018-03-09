/*local PANEL = {}
	local gradient = nut.util.getMaterial("vgui/gradient-u")
	local gradient2 = nut.util.getMaterial("vgui/gradient-d")

	function PANEL:Init()
		self:SetTall(20)

		self.value = 0
		self.deltaValue = self.value
		self.max = 1

		self.bartrait = self:Add("DPanel")
		self.bartrait:Dock(FILL)
		self.bartrait.Paint = function(this, w, h)
			surface.SetDrawColor(35, 35, 255, 250)
			--surface.DrawRect(0, 0, w, h)

			w, h = w - 4, h - 4

			local value = self.deltaValue / self.max

			if (value > 0) then
				local color = nut.config.get("color")
				local boostedValue = self.boostValue or 0
				local add = 0

				if (self.deltaValue != self.value) then
					add = 35
				end

				-- your stat
				do	
						surface.SetDrawColor(color.r + add, color.g + add, color.b + add, 230)
						surface.DrawRect(2, 2, w * value, h)

						surface.SetDrawColor(255, 100, 100, 35)
						surface.SetMaterial(gradient)
						--surface.DrawTexturedRect(2, 2, w - 1, h)
					end

				
			end

			surface.SetDrawColor(255, 255, 255, 5)
			surface.SetMaterial(gradient2)
			--surface.DrawTexturedRect(2, 2, w , h)
		end

		self.labeltrait = self.bartrait:Add("DLabel")
		self.labeltrait:Dock(FILL)
		self.labeltrait:SetExpensiveShadow(0, Color(0, 0, 60))
		self.labeltrait:SetContentAlignment(5)
	end

	function PANEL:Think()
		if (self.pressing) then
			if ((self.nextPress or 0) < CurTime()) then
				self:doChange()
			end
		end

		self.deltaValue = math.Approach(self.deltaValue, self.value, FrameTime() * 15)
	end

	function PANEL:doChange()
		if ((self.value == 0 and self.pressing == -1) or (self.value == self.max and self.pressing == 1)) then
			return
		end
		
		self.nextPress = CurTime() + 0.2
		
		if (self:onChanged(self.pressing) != false) then
			self.value = math.Clamp(self.value + self.pressing, 0, self.max)
		end
	end

	function PANEL:onChanged(difference)
	end

	function PANEL:getValue()
		return self.value
	end

	function PANEL:setValue(value)
		self.value = value
	end

	function PANEL:setBoost(value)
		self.boostValue = value
	end

	function PANEL:setMax(max)
		self.max = max
	end

	function PANEL:setText(text)

		self.labeltrait:Dock(TOP)
		self.labeltrait:SetFont("nutMediumFont")
		self.labeltrait:SetTextColor(color_white)
		self.labeltrait:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		self.labeltrait:DockMargin(0, 10, 0, 0)
		self.labeltrait:SetText(L"Traits")
	end

vgui.Register("nutTraitsbar", PANEL, "DPanel")