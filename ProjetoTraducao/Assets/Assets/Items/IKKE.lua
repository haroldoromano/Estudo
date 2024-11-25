--
--	KHAZRIMI KEY
--		+2 Green Mana on enemy spell	
--




------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_MANA_EARTH(characterIdx,2);
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

IKKE = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};



