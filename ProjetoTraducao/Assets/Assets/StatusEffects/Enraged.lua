--
--	ENRAGED
--		Doubles Battle Skill
--


local function OnQuerySkill(value,characterIdx,skillIdx)

	if (skillIdx == SKILL_BATTLE) then
		value = value + GET_MANA_FIRE(characterIdx);
	end
	return value;
end

--	
--		DECLARE TABLE	
--

Enraged = {
	OnQuerySkill = OnQuerySkill,
};

