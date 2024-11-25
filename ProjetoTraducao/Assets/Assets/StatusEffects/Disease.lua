--
--	DISEASE
--		-1 every mana each turn
--


local function OnStartTurn(characterIdx,turnNumber)

	    
	SUBTRACT_MANA_AIR(characterIdx,1);
	SUBTRACT_MANA_EARTH(characterIdx,1);
	SUBTRACT_MANA_FIRE(characterIdx,1);
	SUBTRACT_MANA_WATER(characterIdx,1);
		
	-- Special FX on caster
	ADD_EFFECT_TO_CHARACTER(characterIdx,"RedSparkle");
	
	return;
end

--	
--		DECLARE TABLE	
--

Disease = {
	OnStartTurn = OnStartTurn,
};

