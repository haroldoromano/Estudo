--
--	HASTE
--		Whenever you get an extra turn, it does +4 damage to your enemies
--


local function OnExtraTurn(characterIdx)

	Std_InflictDamage(4,characterIdx);

	return;
end

--	
--		DECLARE TABLE	
--

Hasted = {
	OnExtraTurn = OnExtraTurn,
};

