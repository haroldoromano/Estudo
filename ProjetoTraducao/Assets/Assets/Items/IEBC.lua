--
--	Earthblood Cloak
--		+2 Earth Resistance whenever an enemy casts a spell	
--




------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_TEMP_RESISTANCE(characterIdx,MANA_GREEN,2);
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

IEBC = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};






