--
--	SILVER DRAGON ORB
--		+1 blue mana per turn 	
--


local function OnStartTurn(characterIdx,turnNumber)

	if (GET_MANA_WATER(characterIdx) < GET_MAX_MANA_WATER(characterIdx)) then
		ADD_MANA_WATER(characterIdx,1);
		ADD_EFFECT_TO_CHARACTER(characterIdx,"CyanSparkle");	
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	
	return;
end

--	
--		DECLARE TABLE	
--

ISDO = {
	OnStartTurn = OnStartTurn,
};


