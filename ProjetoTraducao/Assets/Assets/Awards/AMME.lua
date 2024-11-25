--
--	AMME
--		+4 Cunning
--		Benefit	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
 	QUEST_ADD_SKILL(SKILL_CUNNING,4);		 
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
 	QUEST_ADD_SKILL(SKILL_CUNNING,-4);		 
end


--	
--		DECLARE TABLE	
--

AMME = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};






