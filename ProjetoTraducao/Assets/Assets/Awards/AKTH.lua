--
--	AKTH
--		Theiran Knight
--		+2 Fire Skill	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
	QUEST_ADD_SKILL(SKILL_FIRE,2);	
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_FIRE,-2);	
end


--	
--		DECLARE TABLE	
--

AKTH = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};





