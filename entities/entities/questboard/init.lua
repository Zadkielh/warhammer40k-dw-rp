AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString( "DrawDerma" )
-- Function that runs when you spawn the entity

function ENT:Initialize()

	self:SetModel("models/props_c17/Frame002a.mdl") -- Sets ent model
	self:PhysicsInit(SOLID_VPHYSICS) -- Sets the physics of the ent
	self:SetMoveType(MOVETYPE_VPHYSICS) -- Sets the physic based movement of the ent
	self:SetSolid(SOLID_VPHYSICS) -- Sets up the collisions
	self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject() -- Gets physics via variable

	if phys:IsValid() then -- if our ent physics is valid then

		phys:Wake() -- Wakey wakey physics

	end

end

function ENT:Use( ply, caller )

	if IsValid(caller) and caller:IsPlayer() then
		net.Start( "DrawDerma", false )
		net.Send( ply )
    end
end