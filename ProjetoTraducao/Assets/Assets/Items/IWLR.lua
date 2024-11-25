--
--	Wall (basic)
--		City Item (Pos=1, wall)
--		+50 Life	
--




------------------------------------------------
--
-- OnStartBattle
--
--    Called whenever a new battle is started
--    before the first player takes a turn
--
local function OnStartBattle(characterIdx)
	ADD_MAX_LIFE(characterIdx,20);
	ADD_LIFE(characterIdx,20);
end


--	
--		DECLARE TABLE	
--

IWLR = {
	OnStartBattle = OnStartBattle,
};








