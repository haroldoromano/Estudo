--
--	Wall (basic)
--		City Item (Pos=1, wall)
--		+20 Life	
--




------------------------------------------------
--
-- OnStartBattle
--
--    Called whenever a new battle is started
--    before the first player takes a turn
--
local function OnStartBattle(characterIdx)
	ADD_MAX_LIFE(characterIdx,50);
	ADD_LIFE(characterIdx,50);
end


--	
--		DECLARE TABLE	
--

IWLS = {
	OnStartBattle = OnStartBattle,
};







