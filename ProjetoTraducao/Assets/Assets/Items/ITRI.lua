--
--	TROLL RING
--		+1 life each turn if water >= 6 	
--


local function OnStartTurn(characterIdx,turnNumber)

	if (GET_LIFE(characterIdx) > 0 and GET_LIFE(characterIdx) < GET_MAX_LIFE(characterIdx) and
	    GET_MANA_WATER(characterIdx) >= 6) then
	    
		local amt = 1;
		ADD_LIFE(characterIdx,amt);
		
		-- Special FX on caster
		ADD_EFFECT_TO_CHARACTER(characterIdx,"Spell0");
		ADD_EFFECT_TO_CHARACTER(characterIdx,"Spell1");
	
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	
	return;
end

--	
--		DECLARE TABLE	
--

ITRI = {
	OnStartTurn = OnStartTurn,
};


