--
--	KEY OF POWER
--		+4 to all 4 mana skills 	
--


local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == SKILL_AIR) then
		value = value + 4;
	elseif (skillIdx == SKILL_EARTH) then
		value = value + 4;
	elseif (skillIdx == SKILL_FIRE) then
		value = value + 4;
	elseif (skillIdx == SKILL_WATER) then
		value = value + 4;
	end
	return value;
end

--	
--		DECLARE TABLE	
--

IKOP = {
	OnQuerySkill = OnQuerySkill,
};


