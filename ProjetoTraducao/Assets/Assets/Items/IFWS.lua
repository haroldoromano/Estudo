--
--	FIREWALKER'S TAFF
--		+5% Fire Resistance & +1 damage per 4 Red Mana

------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)
	if (manaIdx == MANA_RED) then
		value = value + 5;
	end
	return value;
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
	if (damage >= 3) then 
		damage = damage + GET_MANA_FIRE(sourceIdx)/8;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end


--




--	
--		DECLARE TABLE	
--

IFWS = {
	OnGiveDamage = OnGiveDamage,
	OnQueryResistance = OnQueryResistance,
};









