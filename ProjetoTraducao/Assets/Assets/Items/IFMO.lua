--
--	FIRE MOAT
--		City Item (Special, Pos #4)
--		Double Red & +1 to all damage






------------------------------------------------
--
-- OnReceiveMana
--
--    Called whenever a character receives mana
--    Must return the amount of mana received (value)
--     manaType is one of MANA_GREEN, MANA_RED, etc...
--
local function OnReceiveMana(value,characterIdx,manaType)

	if (manaType == MANA_RED) then
		value = value*2;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end

------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)
	damage = damage + 1;
	return damage
end




--	
--		DECLARE TABLE	
--

IFMO = {
	OnGiveDamage = OnGiveDamage,
	OnReceiveMana = OnReceiveMana,
};










