ITEM.name = "Armour Base"
ITEM.model = "models/Items/hevsuit.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "A Suit of Armour"
ITEM.category = "Armour"
ITEM.armour = 0
ITEM.setmodel = ""
ITEM.bnum = 0
ITEM.bcat = 0
ITEM.bodygroups = ""
ITEM.faction = {}

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
		if (item:getData("armor")) then
			local armor = item:getData("armor") or 100
			draw.SimpleText(item:getData("armor") .. " Armour", "nutMenuButtonFontNew", x, y, Color((255 / 100) * (100 - armor), (255 / 100) * armor, 0, 255))
			if item:getData("armor") == 0 then
				surface.SetDrawColor(255, 110, 110, 100)
				surface.DrawRect(w - 14, h - 14, 8, 8)
			end
		end
	end
end
		

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	onRun = function(item)
		local char = item.player:getChar()
		
		if item.faction == nil then
			
			item:setData("equip", true)
			
			item.oldModel = item.player:GetModel()
			item.oldArmour = item.player:Armor()
			item.player:SetModel(item.setmodel)
			item.player:SetBodygroup(item.bnum, item.bcat)
			item.player:SetBodyGroups( item.bodygroups )
			item.player:SetSkin( 1 )
		
				if item.saveArmour == nil then
					item.player:SetArmor(item.armour)
					item:setData("armor", item.armour)
					
				elseif item.saveArmour == 0 then
					item:setData("equip", false)
					item:setData("armor", item.saveArmour)
					
				elseif item.saveArmour < item.armour then
					item.player:SetArmor(item.saveArmour)
					item.player:notify("Armour is damaged")	
					item:setData("armor", item.saveArmour)
				else
					item.player:SetArmor(item.armour)
					item:setData("armor", item.armour)
				end
		
			item.player:notify("Equiping armour")
			
		
			return false
		elseif item.faction != nil then
		
			if char:getFaction() == item.faction then
		
			
				item:setData("equip", true)
			
				item.oldModel = item.player:GetModel()
				item.oldArmour = item.player:Armor()
				item.player:SetModel(item.setmodel)
				item.player:SetBodygroup(item.bnum, item.bcat)
				item.player:SetBodyGroups( item.bodygroups )
				item.player:SetSkin( 1 )

		
					if item.saveArmour == nil then
						item.player:SetArmor(item.armour)
						item:setData("armor", item.armour)
					
					elseif item.saveArmour == 0 then
						item:setData("equip", false)
						item:setData("armor", item.saveArmour)
					
					elseif item.saveArmour < item.armour then
						item.player:SetArmor(item.saveArmour)
						item.player:notify("Armour is damaged")	
						item:setData("armor", item.saveArmour)
					else
						item.player:SetArmor(item.armour)
						item:setData("armor", item.armour)
					end
		
				item.player:notify("Equiping armour")
			
		
				return false
		
				else 
					item.player:notify("Invalid Faction")	
				return false
		
			
			end
		end
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true)
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		
		if item:getData("equip") == true then
		item.saveArmour = item.player:Armor()
		end
		
		item.player:SetArmor(item.oldArmour)
		item.player:notify("Removing armour")
		item.player:SetModel(item.oldModel)
		item.player:SetBodygroup(0, item.bcat)
		item.player:SetBodyGroups( "000000000" )
		item.player:SetSkin( 0 )
		
		item:setData("equip", nil)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end

}