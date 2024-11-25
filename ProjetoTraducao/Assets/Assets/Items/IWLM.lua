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
	ADD_MAX_LIFE(characterIdx,200);
	ADD_LIFE(characterIdx,200);
end


--	
--		DECLARE TABLE	
--

IWLM = {
	OnStartBattle = OnStartBattle,
};








