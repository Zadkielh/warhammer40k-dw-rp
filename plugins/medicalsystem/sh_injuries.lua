-- Injury Tables


MajorParts = {
	"Upper Abdomen",
	"Lower Abdomen",
	"Lattisimus Dorsi",
	"Erector Spinae",
	"Teres Major",
	"Pectoralis Major"
}

Parts = {
	"Shin",
	"Arm",
	"Knee",
	"Elbow"
}

MajorInjuries = {}
ModerateInjuries = {}
MinorInjuries = {}
MovementInjuries = {}

------------------------------------------------------------ MajorInjuries ------------------------------------------------------------

	MajorInjuries[0] = {
		name = "Severe Concussion",
		desc = "AGH! MY HEAD, IT.. HURTS!\nI require the aid of an apothecary immediatly",
		attribute = "intelligence",
		modifier = -15
		}
	MajorInjuries[1] = {
		name = "Cracked Skull",
		desc = "*Groans extremely loud*\nI require the aid of an apothecary immediatly",
		attribute = "intelligence",
		modifier = -15
		}
	MajorInjuries[2] = {
		name = "Punctured Lung",
		desc = "*Sharp breaths*\nMy breathing is severly hindered\nI require the aid of an apothecary immediatly",
		attribute = "stm",
		modifier = -15
		}
	MajorInjuries[3] = {
		name = "Pireced Liver",
		desc = "*Excrutiating pain in the upper abdomen*\nI require the aid of an apothecary immediatly",
		attribute = "end",
		modifier = -15
		}
	MajorInjuries[4] = {
		name = "Punctured Stomach",
		desc = "*Excrutiating pain in the mid abdomen*\nI require the aid of an apothecary immediatly",
		attribute = "con",
		modifier = -15
		}
	MajorInjuries[6] = {
		name = "Severed Limb",
		desc = "*Excrutiating pain*\nI require the aid of an apothecary immediatly",
		attribute = "dex",
		modifier = -15
		}
	MajorInjuries[7] = {
		name = "Third Degree Burn",
		desc = "*Excrutiating pain*\nI require the aid of an apothecary immediatly",
		attribute = "con",
		modifier = -15
		}
	MajorInjuries[8] = {
		name = "Severe Infection",
		desc = "*groans loudly*\nYour wounds have a yellow-ish layer.\nI require the aid of an apothecary immediatly",
		attribute = "con",
		modifier = -15
		}
		
------------------------------------------------------------ ModerateInjuries ------------------------------------------------------------

	ModerateInjuries[0] = {
		name = "Broken Arm",
		desc = "Ugh.. My arm seems useless in this state.\nI should seek an apothecary.",
		attribute = "str",
		modifier = -10
		}
	ModerateInjuries[1] = {
		name = "Light Concussion",
		desc = "*clenches eyes*\n*blinks rapidly*\nIt's hard to see.\nA wise action would be to seek an apothecary",
		attribute = "intelligence",
		modifier = -10
		}
	ModerateInjuries[2] = {
		name = math.random(4, 9).." Broken Ribs",
		desc = "*groans*\nThere's something wrong with my chest.\nI require the aid of an apothecary",
		attribute = "con",
		modifier = -10
		}
	ModerateInjuries[3] = {
		name = "Laceration",
		desc = "*groans loudly* This cut runs deep.\nI should seek an apothecary.",
		attribute = "dex",
		modifier = -10
		}
	ModerateInjuries[4] = {
		name = "Shrapnel in" .. MajorParts[math.random(#MajorParts)],
		desc = "*groans loudly* I think some shrapnel got lodged inside me.\nI should seek an apothecary.",
		attribute = "dex",
		modifier = -10
		}
	ModerateInjuries[4] = {
		name = "Second Degree Burns",
		desc = "*groans loudly*\nBlisters appear on the skin.\nI require the aid of an apothecary",
		attribute = "con",
		modifier = -10
		}
	ModerateInjuries[5] = {
		name = "Infection",
		desc = "*groans* \n Your wounds have a yellow-ish layer.\nI require the aid of an apothecary",
		attribute = "con",
		modifier = -10
		}

------------------------------------------------------------ MinorInjuries ------------------------------------------------------------

	MinorInjuries[0] = {
		name = "Bruise",
		desc = "I think i brusied my " .. Parts[math.random(#Parts)],
		}
	MinorInjuries[1] = {
		name = "Scracth",
		desc = "I scratched my " ..  Parts[math.random(#Parts)],
		}
	MinorInjuries[2] = {
		name = math.random(1, 3).." Broken Ribs",
		desc = "There's a slight pain in my chest.",
		}

------------------------------------------------------------ MovementInjuries ------------------------------------------------------------
	
	MovementInjuries[0] = {
		name = "Bruised Hip",
		desc = "This pain in my hip worsens. I must seek an apothecary soon.",
		walk = 180,
		run = 200
		}
	
	MovementInjuries[1] = {
		name = "Fractured Foot Bone",
		desc = "This foot is useless in this state. I better seek an apothecary.",
		walk = 160,
		run = 180
		}
	
	MovementInjuries[2] = {
		name = "Sprained Ankle",
		desc = "I can't walk properly with this ankle.\nMight be wise to seek an apothecary.",
		walk = 140,
		run = 160
		}

	MovementInjuries[3] = {
		name = "Broken Leg",
		desc = "The bone is protruding out of my leg.\nSeeking an apothecary would be wise.",
		walk = 120,
		run = 140
		}
		
