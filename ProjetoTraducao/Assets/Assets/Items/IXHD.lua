--
--	EXTRA HEAD
--		Extra turn when receiving Gold or XP	
--




------------------------------------------------
--
-- OnReceiveGold
--
--    Called whenever a character receives Gold
--    Must return the amount of Gold received (value)
--
local function OnReceiveGold(value,characterIdx)

	EXTRA_TURN(1,1);
	local msg = GET_TEXT("[EXTRATURN]");
	ADD_TEXT_MESSAGE2(msg,2,6);
	NOTIFY_OF_ACTIVATED_ITEM();

	return value
end



--	
--		DECLARE TABLE	
--

IXHD = {
	OnReceiveGold = OnReceiveGold,
};





