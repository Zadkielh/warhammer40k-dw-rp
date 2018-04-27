local PANEL = {}
    local paintFunctions = {}
    paintFunctions[0] = function(this, w, h)
        surface.SetDrawColor(0, 0, 0, 50)
        surface.DrawRect(0, 0, w, h)
    end
    paintFunctions[1] = function(this, w, h)
    end
 
    function PANEL:Init()
		
		if (IsValid(nut.gui.squads)) then
			nut.gui.squads:Remove()
		end

		nut.gui.squads = self
		
        self:SetSize(128, ScrH)
        self:SetPos(ScrW() * 0.1, ScrH() / 2)
 
        self.teams = {}
        self.slots = {}
        self.i = {}

			local list = self:Add("DListLayout")
			list:Dock(TOP)
			list:SetTall(28)
			list.Think = function(this)
				for k, v in ipairs(team.GetPlayers(LocalPlayer():Team())) do
					if !(v == LocalPlayer()) then 
						if (!IsValid(v.nutSquadSlot) or v.nutSquadSlot:GetParent() != this) then
							if (IsValid(v.nutPlayerSlot)) then
								v.nutPlayerSlot:SetParent(this)
							else
								self:addPlayer(v, this)
							end
						end
					end
				end
			end
		end

 
    function PANEL:Think()
        if ((self.nextUpdate or 0) < CurTime()) then
 
            local visible, amount
 
            for k, v in pairs(self.slots) do
                if (IsValid(v)) then
                    v:update()
                end
            end
 
            self.nextUpdate = CurTime() + 0.1
        end
    end
 
    function PANEL:addPlayer(client, parent)
        if (!client:getChar() or !IsValid(parent)) then
            return
        end
 
        local slot = parent:Add("DPanel")
        slot:Dock(TOP)
        slot:SetTall(64)
        slot:DockMargin(0, 0, 0, 1)
        slot.character = client:getChar()
 
        client.nutSquadSlot = slot
 
        slot.model = slot:Add("nutSpawnIcon")
        slot.model:SetModel(client:GetModel(), client:GetSkin())
        slot.model:SetSize(64, 64)
 
        timer.Simple(0, function()
            if (!IsValid(slot)) then
                return
            end
 
            local entity = slot.model.Entity
 
            if (IsValid(entity)) then
                for k, v in ipairs(client:GetBodyGroups()) do
                    entity:SetBodygroup(v.id, client:GetBodygroup(v.id))
                end
 
                for k, v in ipairs(client:GetMaterials()) do
                    entity:SetSubMaterial(k - 1, client:GetSubMaterial(k - 1))
                end
            end
        end)
 
        slot.name = slot:Add("DLabel")
        slot.name:SetText(client:Name())
        slot.name:Dock(TOP)
        slot.name:DockMargin(65, 0, 48, 0)
        slot.name:SetTall(18)
        slot.name:SetFont("nutGenericFont")
        slot.name:SetTextColor(color_white)
        slot.name:SetExpensiveShadow(1, color_black)
 
        local oldTeam = client:Team()
 
        function slot:update()
            if (!IsValid(client) or !client:getChar() or !self.character or self.character != client:getChar() or oldTeam != client:Team()) then
                self:Remove()
 
                local i = 0
 
                for k, v in ipairs(parent:GetChildren()) do
                    if (IsValid(v.model) and v != self) then
                        i = i + 1
                        v.Paint = paintFunctions[i % 2]
                    end
                end
 
                return
            end
 
            local name = client:Name()
            local model = client:GetModel()
            local skin = client:GetSkin() 
 
            if (self.lastName != name) then
                self.name:SetText(name)
                self.lastName = name
            end
 
            local entity = self.model.Entity
 
            if (!IsValid(entity)) then
                return
            end
 
            if (self.lastModel != model or self.lastSkin != skin) then
                self.model:SetModel(client:GetModel(), client:GetSkin())
                self.model:SetToolTip(L("sbOptions", client:steamName()))
               
                self.lastModel = model
                self.lastSkin = skin
            end
 
            timer.Simple(0, function()
                if (!IsValid(entity) or !IsValid(client)) then
                    return
                end
 
                for k, v in ipairs(client:GetBodyGroups()) do
                    entity:SetBodygroup(v.id, client:GetBodygroup(v.id))
                end
            end)
        end
 
        self.slots[#self.slots + 1] = slot
 
        parent:SetVisible(true)
        parent:SizeToChildren(false, true)
        parent:InvalidateLayout(true)
 
        local i = 0
 
        for k, v in ipairs(parent:GetChildren()) do
            if (IsValid(v.model)) then
                i = i + 1
                v.Paint = paintFunctions[i % 2]
            end
        end
 
        return slot
    end
 
    function PANEL:Paint(w, h)
        nut.util.drawBlur(self, 10)
 
        surface.SetDrawColor(30, 30, 30, 100)
        surface.DrawRect(0, 0, w, h)
 
        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawOutlinedRect(0, 0, w, h)
    end
vgui.Register("nutSquad", PANEL, "EditablePanel")