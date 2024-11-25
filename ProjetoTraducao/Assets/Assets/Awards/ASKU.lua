--
--	ASKU
--		Description
--		Benefit	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
	QUEST_ADD_SKILL(SKILL_BATTLE,2);	
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_BATTLE,-2);	
end


--	
--		DECLARE TABLE	
--

ASKU = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};





