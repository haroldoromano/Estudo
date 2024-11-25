--
--	SILVER HARP
--		+3 Yellow Mana when enemy casts spell	
--




------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_MANA_AIR(characterIdx,3);
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

ISHP = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};







