--
--	CREST OF SARTEK
--		Power Description	
--




------------------------------------------------
--
-- OnMatch4
--
--    Called whenever a character matches 4
--    gems (and receives an extra turn)
--
local function OnMatch4(characterIdx)
	ADD_TEMP_RESISTANCE(characterIdx,MANA_YELLOW,2);
	ADD_TEMP_RESISTANCE(characterIdx,MANA_GREEN,2);
	ADD_TEMP_RESISTANCE(characterIdx,MANA_RED,2);
	ADD_TEMP_RESISTANCE(characterIdx,MANA_BLUE,2);
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
	ADD_TEMP_RESISTANCE(characterIdx,MANA_YELLOW,5);
	ADD_TEMP_RESISTANCE(characterIdx,MANA_GREEN,5);
	ADD_TEMP_RESISTANCE(characterIdx,MANA_RED,5);
	ADD_TEMP_RESISTANCE(characterIdx,MANA_BLUE,5);
	NOTIFY_OF_ACTIVATED_ITEM();
end



--	
--		DECLARE TABLE	
--

ICSA = {
	OnMatch5 = OnMatch5,
	OnMatch4 = OnMatch4,
};






