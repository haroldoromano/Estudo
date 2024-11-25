--
--	AIMM
--		Immortality
--		+10 Morale	
--


------------------------------------------------
--
-- OnAddAward
--
--    This award has been given to the current hero
--
local function OnAddAward()
	QUEST_ADD_SKILL(SKILL_MORALE,10);		 
end

------------------------------------------------
--
-- OnRemoveAward	
--			
--		This award has been removed from the current hero
--
local function OnRemoveAward()
	QUEST_ADD_SKILL(SKILL_MORALE,-10);		 
end


--	
--		DECLARE TABLE	
--

AIMM = {
	OnAddAward = OnAddAward,
	OnRemoveAward = OnRemoveAward,
};




