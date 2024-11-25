--
--	SKULL TOTEM
--		Gain 2 Green Mana when you get XP 	
--


local function OnReceiveXP(value,characterIdx)
	if (not IS_GAME_OVER()) then
		ADD_MANA_EARTH(characterIdx, 2);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value;
end


--	
--		DECLARE TABLE	
--

ISKT = {
	OnReceiveXP = OnReceiveXP,
};


