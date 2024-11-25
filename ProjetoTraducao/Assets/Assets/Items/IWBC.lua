--
--	WOLFBANE CLOAK
--		Match 4/5 = +1 Water Resistance	
--




------------------------------------------------
--
-- OnMatch4
--
--    Called whenever a character matches 4
--    gems (and receives an extra turn)
--
local function OnMatch4(characterIdx)
	ADD_TEMP_RESISTANCE(characterIdx,MANA_BLUE,1);
	NOTIFY_OF_ACTIVATED_ITEM();
end

------------------------------------------------
--
-- OnMatch5
--
--    Called whenever a character matches 5
--    gems (and receives an extra turn + wildcard)
--
local function OnMatch5(characterIdx)
	ADD_TEMP_RESISTANCE(characterIdx,MANA_BLUE,1);
	NOTIFY_OF_ACTIVATED_ITEM();
end



--	
--		DECLARE TABLE	
--

IWBC = {
	OnMatch5 = OnMatch5,
	OnMatch4 = OnMatch4,
};





