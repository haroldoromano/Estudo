--
--	Runekeeper's Key
--		Adds +5 to all mana when matching 4 or 5 gems	
--




------------------------------------------------
--
-- OnMatch4
--
--    Called whenever a character matches 4
--    gems (and receives an extra turn)
--
local function OnMatch4(characterIdx)
	ADD_MANA_AIR(characterIdx, 5);
	ADD_MANA_WATER(characterIdx, 5);
	ADD_MANA_EARTH(characterIdx, 5);
	ADD_MANA_FIRE(characterIdx, 5);
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
	OnMatch4(characterIdx);
end



--	
--		DECLARE TABLE	
--

IRKK = {
	OnMatch5 = OnMatch5,
	OnMatch4 = OnMatch4,
};





