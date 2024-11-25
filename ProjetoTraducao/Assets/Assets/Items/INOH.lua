--
--	NOBLE HELM
--		Adds +4 to morale	

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
          value = value + 4;
      end
	return value;
end

--


--	
--		DECLARE TABLE	
--

INOH = {
	OnQuerySkill = OnQuerySkill,
};
  



