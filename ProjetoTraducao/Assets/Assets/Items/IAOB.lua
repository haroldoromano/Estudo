--
--	AMULET OF BLOOD
--		+1 Red fopr every point of XP 	
--


local function OnReceiveXP(value,characterIdx)

	if (not IS_GAME_OVER()) then
		ADD_MANA_FIRE(characterIdx, value);
		NOTIFY_OF_ACTIVATED_ITEM();
	end

	return value;
end


--	
--		DECLARE TABLE	
--

IAOB = {
	OnReceiveXP = OnReceiveXP,
};
 

