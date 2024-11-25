--
--	ADFR
--		+2 Morale
--		Benefit	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
	QUEST_ADD_SKILL(SKILL_MORALE,2);		 
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_MORALE,-2);		 
end


--	
--		DECLARE TABLE	
--

ADFR = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};








