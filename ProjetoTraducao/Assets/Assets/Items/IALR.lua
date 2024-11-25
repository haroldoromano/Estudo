--
--	ARKLICHE RING
--		+1 all mana per 3 XP	
--




------------------------------------------------
--
-- OnReceiveXP
--
--    Called whenever a character receives XP
--    Must return the amount of xp received (value)
--
local function OnReceiveXP(value,characterIdx)

	if (value >= 3 and not IS_GAME_OVER()) then
		local mana = value/3;
		ADD_MANA_AIR(characterIdx, mana);
		ADD_MANA_EARTH(characterIdx, mana);
		ADD_MANA_FIRE(characterIdx, mana);
		ADD_MANA_WATER(characterIdx, mana);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value
end



--	
--		DECLARE TABLE	
--

IALR = {
	OnReceiveXP = OnReceiveXP,
};








