--
--	VIGILED
--		On a Match4/5, gain 5 of each mana
--

local function ManaGain(characterIdx)
	ADD_MANA_AIR(characterIdx,3);
	ADD_MANA_EARTH(characterIdx,3);
	ADD_MANA_FIRE(characterIdx,3);
	ADD_MANA_WATER(characterIdx,3);
end

local function OnMatch4(characterIdx)
	ManaGain(characterIdx);
end

local function OnMatch5(characterIdx)
	ManaGain(characterIdx);
end

--	
--		DECLARE TABLE	
--

Vigiled = {
	OnMatch4 = OnMatch4,
	OnMatch5 = OnMatch5,
};

