--
--	GREAT ONES HORN
--		+8 Morale, Cunning, Battle 	
--


local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == SKILL_BATTLE or skillIdx == SKILL_CUNNING or skillIdx == SKILL_MORALE) then
		value = value + 8;
	end
	return value;
end

--	
--		DECLARE TABLE	
--

IGOH = {
	OnQuerySkill = OnQuerySkill,
};



