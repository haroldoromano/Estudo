--
--	AMOA
--		Master of the Axe
--		+4 Battle	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
	QUEST_ADD_SKILL(SKILL_BATTLE,4);	
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_BATTLE,-4);	
end


--	
--		DECLARE TABLE	
--

AMOA = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};






