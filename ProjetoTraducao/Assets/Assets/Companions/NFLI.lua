--
--	FLICKER
--		Smartass Dragon	
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
	if (CHECK_TYPE(otherIdx,"Flying") == 1) then
		ADD_TEMP_RESISTANCE(characterIdx,MANA_YELLOW,10);
		ACTIVATE_COMPANION("NFLI");
	end
	return;
end




--	
--		DECLARE TABLE	
--

NFLI = {
   OnStartBattle = OnStartBattle,
};


















