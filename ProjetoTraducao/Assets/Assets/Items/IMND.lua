--
--	MANA NODE
--		City Item (Special, Pos #4)
--		+2 all skills when an enemy casts a spell	






------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)
	ADD_TEMP_SKILL(characterIdx, 0, 5); 
	ADD_TEMP_SKILL(characterIdx, 1, 5); 
	ADD_TEMP_SKILL(characterIdx, 2, 5); 
	ADD_TEMP_SKILL(characterIdx, 3, 5); 
	ADD_TEMP_SKILL(characterIdx, 4, 5); 
	ADD_TEMP_SKILL(characterIdx, 5, 5); 
	ADD_TEMP_SKILL(characterIdx, 6, 5); 
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

IMND = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};









