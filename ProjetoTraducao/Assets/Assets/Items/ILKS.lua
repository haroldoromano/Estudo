--
--	LUCKY STONES
--		+6 Cunning skill 	
--


local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == 5) then
		value = value + 6;
	end
	return value;
end

--	
--		DECLARE TABLE	
--

ILKS = {
	OnQuerySkill = OnQuerySkill,
};


