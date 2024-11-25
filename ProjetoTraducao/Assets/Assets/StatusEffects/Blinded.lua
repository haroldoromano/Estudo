--
--	BLINDED
--		No spells or special abilities may be used
--


local function OnStartTurn(characterIdx,turnNumber)

	DISALLOW_SPELLS_THIS_TURN();
	
	return;
end

--	
--		DECLARE TABLE	
--

Blinded = {
	OnStartTurn = OnStartTurn,
};

