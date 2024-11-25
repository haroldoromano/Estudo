--
--	HEIROPHANT'S STAFF
--		+2 Green/Yellow Mana whenever ANY spell is cast	
--

local function OnCastSpell(characterIdx)
	ADD_MANA_AIR(characterIdx,2);
	ADD_MANA_EARTH(characterIdx,2);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_MANA_AIR(characterIdx,2);
	ADD_MANA_EARTH(characterIdx,2);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IHSF = {
	OnCastSpell = OnCastSpell,
	OnEnemyCastSpell = OnEnemyCastSpell,
};
   



