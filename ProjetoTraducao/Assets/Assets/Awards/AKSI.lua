--
--	AKSI
--		Sirian Knight
--		+3 Morale Skill	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
	QUEST_ADD_SKILL(SKILL_MORALE,3);	
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_MORALE,-3);	
end


--	
--		DECLARE TABLE	
--

AKSI = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};





