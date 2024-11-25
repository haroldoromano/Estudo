--
--	AFWK
--		Firewalker
--		+4 Fire Mastery	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
	QUEST_ADD_SKILL(SKILL_FIRE,4);		 
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_FIRE,-4);		 
end


--	
--		DECLARE TABLE	
--

AFWK = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};






