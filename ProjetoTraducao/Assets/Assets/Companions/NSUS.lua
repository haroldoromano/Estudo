--
--	SUNSPEAR
--		+10 Red Mana	
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
	if (CHECK_TYPE(otherIdx,"Undead") == 1 or 
	    CHECK_TYPE(otherIdx,"Minotaur") == 1) then

		ADD_MANA_FIRE(characterIdx,10);
		ACTIVATE_COMPANION("NSUS");

	end

	return;
end




--	
--		DECLARE TABLE	
--

NSUS = {
   OnStartBattle = OnStartBattle,
};















