--
--	SPINE OF SARTEK
--		+20 Morale	
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

	if (skillIdx == SKILL_MORALE) then
		value = value + 20;
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IBSA = {
	OnQuerySkill = OnQuerySkill,
};





