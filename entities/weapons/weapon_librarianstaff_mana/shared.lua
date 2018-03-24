SWEP.Base = "tfa_melee_base"
SWEP.Category = "Warhammer 40k: Librarian"
SWEP.PrintName = "Librarian Staff"
SWEP.ViewModel = "models/zadkiel/weapons/c_oren_katana.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelFOV = 80
SWEP.UseHands = true
SWEP.CameraOffset = Angle(0, 0, 0)
--SWEP.InspectPos = Vector(17.184, -4.891, -11.902) - SWEP.VMPos
--SWEP.InspectAng = Vector(70, 46.431, 70)
SWEP.WorldModel = "models/zadkiel/weapons/sword_daemonblade.mdl"
SWEP.HoldType = "melee2"
SWEP.Primary.Directional = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.DisableIdleAnimations = false
SWEP.VMPos = Vector(5, 7, -6)

SWEP.AllowSprintAttack = false

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID-- ANI = mdl, Hybrid = ani + lua, Lua = lua only
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-10, -2.5, 2.5)


SWEP.CanBlock = true
SWEP.BlockAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DEPLOY, --Number for act, String/Number for sequence
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_DEPLOYED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["hit"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_DEPLOYED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},--when you get hit and block it
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_UNDEPLOY, --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}
SWEP.BlockCone = 360 --Think of the player's view direction as being the middle of a sector, with the sector's angle being this
SWEP.BlockDamageMaximum = 0.0 --Multiply damage by this for a maximumly effective block
SWEP.BlockDamageMinimum = 0.0 --Multiply damage by this for a minimumly effective block
SWEP.BlockTimeWindow = 1 --Time to absorb maximum damage
SWEP.BlockTimeFade = 0.5 --Time for blocking to do minimum damage.  Does not include block window
SWEP.BlockSound = Sound("block_1.wav")
SWEP.BlockDamageCap = 500
SWEP.BlockDamageTypes = {
	DMG_SLASH,DMG_CLUB, DMG_BULLET, DMG_BURN, DMG_BLAST
}

SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 120
SWEP.Secondary.BashDelay = 0.1
SWEP.Secondary.BashLength = 60 * 3

SWEP.SequenceLengthOverride = {
	[ACT_VM_HITCENTER] = 0.8
}

SWEP.ViewModelBoneMods = {
	["RW_Weapon"] = { scale = Vector(0.01, 0.01, 0.01), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}
SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/zadkiel/weapons/librarian_staff.mdl", bone = "RW_Weapon", rel = "", pos = Vector(0, 3, -30.596), angle = Angle(-3.507, 94.675, -0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {[1] = 17, [2] = 4} }
}
SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/zadkiel/weapons/librarian_staff.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 1, 56.792), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {[1] = 17, [2] = 4} }
}
SWEP.InspectionActions = {ACT_VM_RECOIL1, ACT_VM_RECOIL2, ACT_VM_RECOIL3}

local DenySound = Sound( "WallHealth.Deny" )


function SWEP:SecondaryAttack()
if (CLIENT) then return end
	local mana = self.Owner:getLocalVar("psy", 0)
	if mana < 15 then
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 )
		self.Owner:EmitSound( DenySound )
		return false
			
	else
		self.Owner:setLocalVar("psy", math.max(mana - 15, 0))
	end

	self.Owner:MuzzleFlash()

	self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 )


	local SpawnBlaserRod = ents.Create("obj_vj_lib_smite")
	local OwnerPos = self.Owner:GetShootPos()
	local OwnerAng = self.Owner:GetAimVector():Angle()
	OwnerPos = OwnerPos + OwnerAng:Forward()*-20 + OwnerAng:Up()*-9 + OwnerAng:Right()*10
	if self.Owner:IsPlayer() then SpawnBlaserRod:SetPos(OwnerPos) else SpawnBlaserRod:SetPos(self:GetAttachment(self:LookupAttachment("missile")).Pos) end
	if self.Owner:IsPlayer() then SpawnBlaserRod:SetAngles(OwnerAng) else SpawnBlaserRod:SetAngles(self.Owner:GetAngles()) end
	SpawnBlaserRod:SetOwner(self.Owner)
	SpawnBlaserRod:Activate()
	SpawnBlaserRod:Spawn()
	
	local phy = SpawnBlaserRod:GetPhysicsObject()
	if phy:IsValid() then
		if self.Owner:IsPlayer() then
		phy:ApplyForceCenter(self.Owner:GetAimVector() * 20000) else //200000
		//phy:ApplyForceCenter((self.Owner:GetEnemy():GetPos() - self.Owner:GetPos()) * 4000)
		phy:ApplyForceCenter(((self.Owner:GetEnemy():GetPos()+self.Owner:GetEnemy():OBBCenter()+self.Owner:GetEnemy():GetUp()*-45) - self.Owner:GetPos()+self.Owner:OBBCenter()+self.Owner:GetEnemy():GetUp()*-45) * 4000)
		//data.Dir = (Entity:GetEnemy():GetPos()+Entity:GetEnemy():OBBCenter()+Entity:GetEnemy():GetUp()*-45) -Entity:GetPos()+Entity:OBBCenter()+Entity:GetEnemy():GetUp()*-45
		end
	end
end

function SWEP:ShouldDropOnDie()
	return false
end
-- function SWEP:Reload() --To do when reloading
-- end 
 

function SWEP:PrimaryAttack()

if (CLIENT) then return end
	local mana = self.Owner:getLocalVar("psy", 0)
	if mana < 20 then
		self:SetNextPrimaryFire( CurTime() + 0.5 )
		self.Owner:EmitSound( DenySound )
		return false
			
	else
		self.Owner:setLocalVar("psy", math.max(mana - 20, 0))
	end

	local Ent = ents.Create("obj_vj_lib_holysmite")
	local OwnerPos = self.Owner:GetShootPos()
	local OwnerAng = self.Owner:GetAimVector():Angle()
	OwnerPos = OwnerPos + OwnerAng:Forward()*-20 + OwnerAng:Up()*-9 + OwnerAng:Right()*10
	if self.Owner:IsPlayer() then Ent:SetPos(OwnerPos) else Ent:SetPos(self:GetAttachment(self:LookupAttachment("missile")).Pos) end
	if self.Owner:IsPlayer() then Ent:SetAngles(OwnerAng) else Ent:SetAngles(self.Owner:GetAngles()) end
	Ent:SetOwner(self.Owner)
	Ent:Activate()
	Ent:Spawn()
	
	local phy = Ent:GetPhysicsObject()
	if phy:IsValid() then
		if self.Owner:IsPlayer() then
		phy:ApplyForceCenter(self.Owner:GetAimVector() * 20000) else //200000
		//phy:ApplyForceCenter((self.Owner:GetEnemy():GetPos() - self.Owner:GetPos()) * 4000)
		phy:ApplyForceCenter(((self.Owner:GetEnemy():GetPos()+self.Owner:GetEnemy():OBBCenter()+self.Owner:GetEnemy():GetUp()*-45) - self.Owner:GetPos()+self.Owner:OBBCenter()+self.Owner:GetEnemy():GetUp()*-45) * 4000)
		//data.Dir = (Entity:GetEnemy():GetPos()+Entity:GetEnemy():OBBCenter()+Entity:GetEnemy():GetUp()*-45) -Entity:GetPos()+Entity:OBBCenter()+Entity:GetEnemy():GetUp()*-45
		end
	end
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )

end
 
 
function SWEP:Deploy()
return true;
end

function SWEP:Holster()
return true;
end