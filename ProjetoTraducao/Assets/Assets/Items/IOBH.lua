--
--	Ogreblood Helm
--		+2 Fire Resistance whenever an enemy casts a spell	
--




------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_TEMP_RESISTANCE(characterIdx,MANA_RED,2);
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

IOBH = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};






