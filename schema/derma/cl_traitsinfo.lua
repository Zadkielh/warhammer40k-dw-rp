/*hook.Add("CreateCharInfo", "traits",function(self)
	
	self.traitName = self.info:Add("DLabel")
	self.traitName:Dock(FILL)
	self.traitName:SetFont("nutMediumFont")
	self.traitName:SetTextColor(color_white)
	self.traitName:SetExpensiveShadow(1, Color(0, 0, 0, 150))
	self.traitName:DockMargin(0, 10, 0, 0)
	self.traitName:SetText(L"Traits")
    self.traits = self.info:Add("nutTraitsBar")

    if (self.traits) then
    
        for k, v in SortedPairsByMemberValue(nut.traits.list, "name") do
            local bar = self.addTraits:Add("nutTraitsBar")
			
            bar:Dock(FILL)
            bar:DockMargin(0, 0, 0, 6)

            bar:setMax(10)
            bar:setReadOnly()
            bar:setText(Format(L(v.name)))
            
            end
        end
end)

hook.Add("CreateCharInfo", "traits",function(self)
    self.traitName = self.info:Add("DLabel")
    self.traitName:Dock(FILL)
    self.traitName:SetFont("nutMediumFont")
    self.traitName:SetTextColor(color_white)
    self.traitName:SetExpensiveShadow(1, Color(0, 0, 0, 150))
    self.traitName:DockMargin(0, 10, 0, 0)
    self.traitName:SetText(L"Traits")
    
    self.traits = self.info:Add("DPanel")
    self.traits:Dock(FILL)
    self.traits:SetTall(96)
    function self.traits:Paint()
        for k, v in SortedPairsByMemberValue(nut.traits.list, "name") do
            surface.SetMaterial(nut.util.getMaterial(v.icon))
            surface.DrawTexturedRect((k-1)*64,0,64,64)

            draw.SimpleText(v.name, "nutMediumFont", (k-1)*64+32, 64+16, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)

