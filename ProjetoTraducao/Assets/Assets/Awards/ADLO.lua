--
--	A000
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
	QUEST_ADD_SKILL(SKILL_AIR,5);		 
	QUEST_ADD_SKILL(SKILL_EARTH,5);		 
	QUEST_ADD_SKILL(SKILL_FIRE,5);		 
	QUEST_ADD_SKILL(SKILL_WATER,5);		 
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_AIR,-5);		 
	QUEST_ADD_SKILL(SKILL_EARTH,-5);		 
	QUEST_ADD_SKILL(SKILL_FIRE,-5);		 
	QUEST_ADD_SKILL(SKILL_WATER,-5);		 
end


--	
--		DECLARE TABLE	
--

ADLO = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};





