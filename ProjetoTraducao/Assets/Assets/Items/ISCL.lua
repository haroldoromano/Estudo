--
--	SORCERORS CLOAK
--		Drain 1 mana on receiving 2+ damage	
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
	if (damage >= 2 and sourceIdx ~= targetIdx) then
		SUBTRACT_MANA_AIR(sourceIdx,2);
		SUBTRACT_MANA_EARTH(sourceIdx,2);
		SUBTRACT_MANA_FIRE(sourceIdx,2);
		SUBTRACT_MANA_WATER(sourceIdx,2);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

ISCL  = {
	OnReceiveDamage = OnReceiveDamage,
};





