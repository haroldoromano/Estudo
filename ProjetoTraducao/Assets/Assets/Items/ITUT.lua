--
--	Practice Shield
--		Owner never takes a turn	
--


------------------------------------------------
--
-- OnStartTurn
--
--    Called at the start of player turn
--    before the turn is actually started
--
local function OnStartTurn(characterIdx,turnNumber)
	MISS_TURNS(characterIdx,1);
	NOTIFY_OF_ACTIVATED_ITEM();
end




--	
--		DECLARE TABLE	
--

ITUT = {
	OnStartTurn = OnStartTurn,
};





