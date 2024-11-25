--
--	AKNG
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
	QUEST_ADD_SKILL(SKILL_MORALE,5);		 
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_MORALE,-5);		 
end


--	
--		DECLARE TABLE	
--

AKNG = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};












