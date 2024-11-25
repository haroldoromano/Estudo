--
--	ARCHDRUID'S STAFF
--		+1 Green/Yellow Mana whenever ANY spell is cast	
--


local function OnCastSpell(characterIdx)
	ADD_MANA_AIR(characterIdx,1);
	ADD_MANA_EARTH(characterIdx,1);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_MANA_AIR(characterIdx,1);
	ADD_MANA_EARTH(characterIdx,1);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IADS = {
	OnCastSpell = OnCastSpell,
	OnEnemyCastSpell = OnEnemyCastSpell,
};
  

