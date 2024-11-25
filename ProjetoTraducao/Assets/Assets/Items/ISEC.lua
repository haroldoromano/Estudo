--
--	SELENTINE CROWN
--		+5 Morale 	
--


local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == 6) then
		value = value + 5;
	end
	return value;
end

--	
--		DECLARE TABLE	
--

ISEC = {
	OnQuerySkill = OnQuerySkill,
};




