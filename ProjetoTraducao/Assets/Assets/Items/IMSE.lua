--
--	MEDAL OF SELENTIA
--		Doubles XP received during battle	
--




------------------------------------------------
--
-- OnReceiveXP
--
--    Called whenever a character receives XP
--    Must return the amount of xp received (value)
--
local function OnReceiveXP(value,characterIdx)
	if (not IS_GAME_OVER()) then
		value = value*2;
	end
	return value
end


--	
--		DECLARE TABLE	
--

IMSE = {
	OnReceiveXP = OnReceiveXP,
};






