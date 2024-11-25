--
--	DOOMKNIGHT ARMOR
--		Protection +1 & +2 Green Mana Found	
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
-- OnReceiveMana
--
--    Called whenever a character receives mana
--    Must return the amount of mana received (value)
--     manaType is one of MANA_GREEN, MANA_RED, etc...
--
local function OnReceiveMana(value,characterIdx,manaType)

	if (manaType == MANA_GREEN) then
		value = value+2;
	end
	return value
end



--	
--		DECLARE TABLE	
--

IDKH = {
	OnReceiveMana = OnReceiveMana,
	OnReceiveDamage = OnReceiveDamage,
};







