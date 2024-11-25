--
--	OGRE'S RING
--		3 Green Mana when enemies cast a spell 	
--


local function OnEnemyCastSpell(characterIdx)
	ADD_MANA_EARTH(characterIdx,3);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IORI = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};


