--
--	CHAOS SKIN
--		+8 Healing on enemy spell	
--




------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)
	Std_Healing2(5, characterIdx);
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

ICSK = {
	OnEnemyCastSpell = OnEnemyCastSpell,
};







