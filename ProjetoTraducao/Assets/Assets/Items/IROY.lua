--
--	RELIC OF YMORGIA
--		+5 Earth Mastery & +5% Earth Resistance	
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

	if (skillIdx == SKILL_EARTH) then
		value = value + 5;
	end
	return value;
end

------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)

	if (manaIdx== MANA_GREEN) then
		value = value + 5;
	end
	return value;
end



--	
--		DECLARE TABLE	
--

IROY = {
	OnQueryResistance = OnQueryResistance,
	OnQuerySkill = OnQuerySkill,
};



