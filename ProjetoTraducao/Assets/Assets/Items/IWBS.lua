--
--	Wyrmblood Stone
--		Adds +2 Air Resistance when an enemy casts a spell

------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_TEMP_RESISTANCE(characterIdx,MANA_YELLOW,2);
	NOTIFY_OF_ACTIVATED_ITEM();
end

--




--	
--		DECLARE TABLE	
--

IWBS = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};






