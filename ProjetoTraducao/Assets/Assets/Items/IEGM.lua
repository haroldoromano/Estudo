--
--	ELEMENTAL GEM
--		Start of turn, ech full reserve gives +2 to other mana	
--




------------------------------------------------
--
-- OnStartTurn
--
--    Called at the start of player turn
--    before the turn is actually started
--
local function OnStartTurn(characterIdx,turnNumber)

	local numFull = 0;
	if (GET_MANA_AIR(characterIdx) >= GET_MAX_MANA_AIR(characterIdx)) then
		numFull = numFull + 1;
	end
	if (GET_MANA_EARTH(characterIdx) >= GET_MAX_MANA_EARTH(characterIdx)) then
		numFull = numFull + 1;
	end
	if (GET_MANA_FIRE(characterIdx) >= GET_MAX_MANA_FIRE(characterIdx)) then
		numFull = numFull + 1;
	end
	if (GET_MANA_WATER(characterIdx) >= GET_MAX_MANA_WATER(characterIdx)) then
		numFull = numFull + 1;
	end

	if (numFull > 0) then
		ADD_MANA_AIR(characterIdx, numFull*2);
		ADD_MANA_EARTH(characterIdx, numFull*2);
		ADD_MANA_FIRE(characterIdx, numFull*2);
		ADD_MANA_WATER(characterIdx, numFull*2);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
end


--	
--		DECLARE TABLE	
--

IEGM = {
	OnStartTurn = OnStartTurn,
};



