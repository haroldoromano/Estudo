--
--	DOOMKNIGHT ARMOR
--		Protection +1 & 10% Earth Resistance	
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
	if (damage > 1) then 
		damage = damage - 1;
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

IDKA = {
	OnQueryResistance = OnQueryResistance,
	OnReceiveDamage = OnReceiveDamage,
};






