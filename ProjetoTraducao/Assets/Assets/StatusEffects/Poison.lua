--
--	POISON
--		-1 life each turn
--


local function OnStartTurn(characterIdx,turnNumber)

	if (GET_LIFE(characterIdx) > 0) then
	    
		SUBTRACT_LIFE(characterIdx,1,characterIdx);
		
		-- Special FX on caster
		ADD_EFFECT_TO_CHARACTER(characterIdx,"GreenSparkle");
	
	end
	
	return;
end

--	
--		DECLARE TABLE	
--

Poison = {
	OnStartTurn = OnStartTurn,
};

