--
--	BANES CROWN
--		+1 Battle, Cunning, Morale per 3 pts of AIR	
--




------------------------------------------------
--
-- OnQuerySkill
--
--    Called whenever the game accesses a skill
--    Must return the value of the skill
--    Skill index is one of SKILL_EARTH, SKILL_FIRE,etc...
--
local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == SKILL_BATTLE or 
		skillIdx == SKILL_CUNNING or
		skillIdx == SKILL_MORALE) then
			value = value + GET_SKILL(characterIdx,SKILL_AIR)/3;
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IBNC = {
	OnQuerySkill = OnQuerySkill,
};






