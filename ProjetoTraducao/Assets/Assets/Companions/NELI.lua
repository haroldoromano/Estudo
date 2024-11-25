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
	if (CHECK_TYPE(otherIdx,"Large") == 1) then
		ADD_TEMP_RESISTANCE(characterIdx,MANA_BLUE,10);
		ACTIVATE_COMPANION("NELI");
	end
	return;
end




--	
--		DECLARE TABLE	
--

NELI = {
   OnStartBattle = OnStartBattle,
};







