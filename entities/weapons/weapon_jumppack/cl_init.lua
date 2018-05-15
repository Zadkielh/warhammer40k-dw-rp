include('shared.lua')

do

	local EFF = {}
	
	function EFF:Init(d)
		local ply = d:GetEntity()
		if not IsValid(ply) then return end
		
		self:SetPos(ply:GetPos())
		
		self.DieTime = CurTime()+1
		self.Emitter = ParticleEmitter(ply:GetPos())
		self.Player = ply
	end
	
	function EFF:Think()
		self.Dead = self.DieTime<CurTime() or self.Player:IsOnGround()
		if self.Dead then
		
			self.Emitter:Finish()
			
		else
		
			local Up = self.Player:EyeAngles():Up()
			local Forward = self.Player:EyeAngles():Forward()
			local Right = self.Player:EyeAngles():Right()
			local Back = self.Player:LookupBone("ValveBiped.Bip01_Spine4")
			local BackPos = self.Player:GetBonePosition(Back)

			local p

			p = self.Emitter:Add("particles/smokey", BackPos + Forward*-30 + Right*-15 + Up*-5)
			p:SetDieTime(1+math.random()*0.5)
			p:SetStartAlpha(180+math.random(55))
			p:SetEndAlpha(0)
			p:SetStartSize(8+math.random()*3)
			p:SetEndSize(2+math.random()*10)
			p:SetRoll(math.random()*3)
			p:SetRollDelta(math.random()*2-1)
			p:SetVelocity( Up*-10 )

			p = self.Emitter:Add("particles/smokey", BackPos + Forward*-30  + Right*15 + Up*-5)
			p:SetDieTime(1+math.random()*0.5)
			p:SetStartAlpha(180+math.random(55))
			p:SetEndAlpha(0)
			p:SetStartSize(8+math.random()*3)
			p:SetEndSize(2+math.random()*10)
			p:SetRoll(math.random()*3)
			p:SetRollDelta(math.random()*2-1)
			p:SetVelocity( Up*-10 )

			p = self.Emitter:Add("sprites/flamelet2", BackPos + Forward*-30 + Right*-15)
			p:SetDieTime(1+math.random()*0.5)
			p:SetStartAlpha(180+math.random(55))
			p:SetEndAlpha(0)
			p:SetStartSize(8+math.random()*3)
			p:SetEndSize(2+math.random()*10)
			p:SetRoll(math.random()*3)
			p:SetRollDelta(math.random()*2-1)
			p:SetVelocity( Up*-10 )

			p = self.Emitter:Add("sprites/flamelet2", BackPos + Forward*-30 + Right*15 )
			p:SetDieTime(1+math.random()*0.5)
			p:SetStartAlpha(180+math.random(55))
			p:SetEndAlpha(0)
			p:SetStartSize(8+math.random()*3)
			p:SetEndSize(2+math.random()*10)
			p:SetRoll(math.random()*3)
			p:SetRollDelta(math.random()*2-1)
			p:SetVelocity( Up*-10 )
			
		end
		
		return not self.Dead
	end
	
	function EFF:Render()
		
	end
	effects.Register(EFF,"jetsmoke")

end

function SWEP:Draw()
end