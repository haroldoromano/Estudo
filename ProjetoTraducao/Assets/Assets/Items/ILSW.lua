--
--	LONGSWORD
--		+4 Battle 	
--


local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == 4) then
		value = value + 4;
	end
	return value;
end

--	
--		DECLARE TABLE	
--

ILSW = {
	OnQuerySkill = OnQuerySkill,
};




