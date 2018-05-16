if CLIENT then
	SWEP.PrintName = "Jump Pack"
	SWEP.Author = "Zadkiel"
	SWEP.Slot = 3
	SWEP.SlotPos = 1
end

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Ammo = "AirboatGun"
SWEP.DrawAmmo = true

SWEP.Secondary.Ammo			= "none"

SWEP.HoldType = "normal"
SWEP.Category = "Warhammer 40k: Weapons"
SWEP.UseHands = false
SWEP.DrawCrosshair= false

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.Automatic= false

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

local JetActivate = Sound("hl1/fvox/activated.wav")
local JetDeactivate = Sound("hl1/fvox/deactivated.wav")

sound.Add(
	{
		name = "JumpThrust",
		sound = "thrusters/rocket01.wav",
		channel = CHAN_BODY,
		pitchstart = 50,
		pitchend = 50,
		level = 80,
		volume = 0.3,
	}
)

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1)
	local JetIsOn = self.Owner:GetNWBool("JumpPackEnabled")
	
	if SERVER then
		self.Owner:SetNWBool("JumpPackEnabled",!JetIsOn)
		if JetIsOn then
			self.Owner:SetAmmo(0, "AirboatGun")
			self.Owner:StopSound("RocketThrust")
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Jump Pack Deactivated" )
		elseif !JetIsOn then
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Jump Pack Activated" )
		end
	elseif CLIENT then
		if JetIsOn then
			surface.PlaySound(JetDeactivate)
		elseif !JetIsOn then
			surface.PlaySound(JetActivate)
		end
	end
end 

if SERVER then
	local function JumpPacking()
		for k,ply in ipairs(player.GetAll()) do
			local multiplier = 3
			if game.SinglePlayer() then
				multiplier = 1
			end
			ply:LagCompensation( true )
			if ply:GetNWBool("JumpPackEnabled") then
				if ( !ply:IsOnGround() ) then
					if (ply:GetAmmoCount("AirboatGun") > 1 and ply:KeyDown(IN_JUMP)) then
						ply:SetVelocity(ply:GetUp() * 30 * multiplier + ply:GetAimVector() * multiplier + ply:GetForward() * 30)
						ply:RemoveAmmo(10, "AirboatGun")
						ply:EmitSound("JumpThrust")
						if ply:GetNWFloat("NextJumpPackEffect")<CurTime() then
							local fx = EffectData()
							fx:SetEntity(ply)
							util.Effect("jetsmoke", fx, true, true)
							ply:SetNWFloat("NextJumpPackEffect",CurTime()+0.95)
						end
					else
						local vel = ply:GetVelocity()
						if vel.z < -10 then
							ply:EmitSound("RocketJumpThrustThrust")
							vel.x = 0
							vel.y = 0
							vel.z = -vel.z * 1 * multiplier / 100
							ply:SetVelocity( vel )
						end
						if ply:GetNWFloat("NextJumpPackEffect")<CurTime() then
							local fx = EffectData()
							fx:SetEntity(ply)
							util.Effect("jetsmoke", fx, true, true)
							ply:SetNWFloat("NextJumpPackEffect",CurTime()+0.95)
						end
					end
				elseif (ply:GetAmmoCount("AirboatGun") < 150) and ply:IsOnGround() then
					ply:StopSound("JumpThrust")
					ply:GiveAmmo(1, "AirboatGun", true)
				end
			end
			ply:LagCompensation( false )
		end
	end
	hook.Add("Think","Jetpush",JumpPacking)

	
	
	local function PlayerDied(ply)
		local JetIsOn = ply:GetNWBool("JumpPackEnabled")
		
		if JetIsOn then
			ply:SetNWBool("JumpPackEnabled",false)
			ply:StopSound("JumpThrust")
		end
	end
	hook.Add("PlayerDeath","RemoveDeadJumpPacks",PlayerDied)
end

function SWEP:SecondaryAttack()
	return
end

function SWEP:Initialize()
	
	self:SetWeaponHoldType(self.HoldType)
	self.Owner:SetNWFloat("NextJumpPackEffect",CurTime())
end

function SWEP:Deploy()
	self.Owner:SetAmmo(0, "AirboatGun")
	self:SetNextPrimaryFire(CurTime() + .2)
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
	return false
end

function SWEP:Reload()
	return
end