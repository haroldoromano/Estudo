--
--	FEAR
--		Halves all skills
--


local function OnQuerySkill(value,characterIdx,skillIdx)

	return value/2;
end

--	
--		DECLARE TABLE	
--

Fear = {
	OnQuerySkill = OnQuerySkill,
};

