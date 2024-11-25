--
--	PALADINS AURA
--		+2 of each mana per turn
--


local function OnStartTurn(characterIdx,turnNumber)

	-- If we are nearing the end
	ADD_MANA_AIR(characterIdx,2);
	ADD_MANA_EARTH(characterIdx,2);
	ADD_MANA_FIRE(characterIdx,2);
	ADD_MANA_WATER(characterIdx,2);

end


--	
--		DECLARE TABLE	
--

PaladinsAuraed = {
	OnStartTurn = OnStartTurn,
};

