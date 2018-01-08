ITEM.name = "Medical Base"
ITEM.model = "models/healthvial.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "A Medical Item"
ITEM.category = "Medical"
ITEM.heal = 1
ITEM.uses = 1
ITEM.reps = 1
ITEM.bandage = false
ITEM.faction = {}




if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("uses")) then
			local uses = item:getData("uses") or 100
			draw.SimpleText(item:getData("uses") .. " Uses left.", "nutMediumFont", x, y, Color((255 / 100) * (100 - uses), (255 / 100) * uses, 0, 255))
			if item:getData("uses") == 0 then
				surface.SetDrawColor(255, 110, 110, 100)
				surface.DrawRect(w - 14, h - 14, 8, 8)
			end
		end
	end
end
		

ITEM.functions.Use = {
	name = "Use",
	tip = "useTip",
	icon = "icon16/tick.png",
	sound = "items/medshot4.wav",
	onRun = function(item)
		local char = item.player:getChar()
		local client = char:getPlayer()
		
			if item.uses > 1 then
				item.uses = item.uses - 1
				
					item.player:SetHealth( item.player:Health() + item.heal )
					
					if timer.Exists( "bleed" ) then
				
						if item.bandage then
						
							item.player:ChatPrint("*Finds the bandage and starts to treat the wound*")
							
							timer.Simple( 5, function()
								client:ChatPrint("*Finishes bandaging*")
								timer.Remove( "bleed" )
							end
							)
						
						
				
						end
					end
				return false
			elseif item.uses == 1 then
			
				item.player:SetHealth( math.min(item.player:Health() + item.heal, item.player:GetMaxHealth() ) )
					
					if timer.Exists( "bleed" ) then
				
						if item.bandage then
						
							item.player:ChatPrint("*Finds the bandage and starts to treat the wound*")
							
							timer.Simple( 5, function()
								client:ChatPrint("*Finishes bandaging*")
								timer.Remove( "bleed" )
							end
							)
						
						
				
						end
					end
			
				return true
			elseif item.uses == nil then
					item.player:SetHealth( item.player:Health() + item.heal )
					item:setData("uses", item.uses)
					return false
			end
	
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
