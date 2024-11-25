--
--	DRUID'S STAFF
--		+1 Green Mana whenever ANY spell is cast	
--


local function OnCastSpell(characterIdx)
	ADD_MANA_EARTH(characterIdx,1);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_MANA_EARTH(characterIdx,1);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IDST = {
	OnCastSpell = OnCastSpell,
	OnEnemyCastSpell = OnEnemyCastSpell,
};
  


