--
--	NEW ITEM
--		Power Description	
--




------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then
		damage = damage + 1;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end

------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)
	if (manaIdx == MANA_GREEN) then
		value = value + 10;
	end
	return value;
end



--	
--		DECLARE TABLE	
--

IDAX = {
	OnQueryResistance = OnQueryResistance,
	OnGiveDamage = OnGiveDamage,
};






