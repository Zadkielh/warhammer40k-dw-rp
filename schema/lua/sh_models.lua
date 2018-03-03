nut.anim.custom = {
	normal = {
		["idle_all_01"] = ACT_HL2MP_IDLE,
		["cidle_all"] = ACT_HL2MP_IDLE_CROUCH,
		["walk_all"] = ACT_HL2MP_WALK,
		["run_all_01"] = ACT_HL2MP_RUN
	},
	passive = {
		["idle_passive"] = ACT_HL2MP_IDLE_PASSIVE,
		["walk_passive"] = ACT_HL2MP_WALK_PASSIVE,
		["cwalk_passive"] = ACT_HL2MP_WALK_CROUCH_PASSIVE,
		["run_passive"] = ACT_HL2MP_RUN_PASSIVE
	}
}


nut.anim.setModelClass("models/zadkiel/deathwatch/apothecary/models/apothecary_marine_players.mdl", "custom")

do
	local playerMeta = FindMetaTable("Player")

	function playerMeta:forceSequence(sequence, callback, time, noFreeze)
		hook.Run("OnPlayerEnterSequence", self, sequence, callback, time, noFreeze)

		if (!sequence) then
			return netstream.Start(nil, "seqSet", self)
		end

		local sequence = self:LookupSequence(sequence)

		if (sequence and sequence > 0) then
			time = time or self:SequenceDuration(sequence)

			self.nutSeqCallback = callback
			self.nutForceSeq = sequence

			if (!noFreeze) then
				self:SetMoveType(MOVETYPE_NONE)
			end

			if (time > 0) then
				timer.Create("nutSeq"..self:EntIndex(), time, 1, function()
					if (IsValid(self)) then
						self:leaveSequence()
					end
				end)
			end

			netstream.Start(nil, "seqSet", self, sequence)

			return time
		end

		return false
	end

	function playerMeta:leaveSequence()
		hook.Run("OnPlayerLeaveSequence", self)

		netstream.Start(nil, "seqSet", self)

		self:SetMoveType(MOVETYPE_WALK)
		self.nutForceSeq = nil

		if (self.nutSeqCallback) then
			self:nutSeqCallback()
		end
	end

	if (CLIENT) then
		netstream.Hook("seqSet", function(entity, sequence)
			if (IsValid(entity)) then
				if (!sequence) then
					entity.nutForceSeq = nil

					return
				end

				entity:SetCycle(0)
				entity:SetPlaybackRate(1)
				entity.nutForceSeq = sequence
			end
		end)
	end
end

msg = "Loaded models and anims successfully."
print(msg)