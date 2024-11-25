--
--	HORNED HELM
--		Gives +3 Red Mana when an enemy casts a spell 	
--


local function OnEnemyCastSpell(characterIdx)
	ADD_MANA_FIRE(characterIdx,3);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IHOH = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};



