--
--	NEW COMPANION
--		Companion Description	
--


------------------------------------------------
--
-- OnStartBattle
--
--    A battle has just started
--    This is called before the first turn
--
local function OnStartBattle(characterIdx)

	-- find the other character
	local otherIdx = 1;
	if (characterIdx == 1) then
		otherIdx = 0;
	end

	-- check the type
	if (CHECK_TYPE(otherIdx,"Machine") == 1 or 
	    CHECK_TYPE(otherIdx,"City") == 1) then
		ADD_TEMP_SKILL(characterIdx,SKILL_BATTLE,10);
		ACTIVATE_COMPANION("NKHA");
	end
	return;
end




--	
--		DECLARE TABLE	
--

NKHA = {
   OnStartBattle = OnStartBattle,
};









