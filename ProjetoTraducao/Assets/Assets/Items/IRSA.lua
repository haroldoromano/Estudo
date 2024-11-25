--
--	RIBS OF SARTEK
--		Protects against 5 damage when you receive 10	
--




------------------------------------------------
--
-- OnReceiveDamage
--
--    Called whenever a character takes damage
--    Must return the amount of damage taken
--     sourceIdx = attacker  targetIdx=me!
--
local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 10) then 
		damage = damage - 5;
		NOTIFY_OF_ACTIVATED_ITEM();
	end

	return damage
end


--	
--		DECLARE TABLE	
--

IRSA = {
	OnReceiveDamage = OnReceiveDamage,
};





