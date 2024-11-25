--
--	NECROTIC STAFF
--		Halves enemy green mana when a spell is cast	
--




------------------------------------------------
--
-- OnCastSpell
--
--    Called whenever a character casts a spell
--
local function OnCastSpell(characterIdx)
	local idxEnemy = GET_ENEMY(characterIdx,0);
	SET_MANA_EARTH(idxEnemy, GET_MANA_EARTH(idxEnemy)/2);
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

INST = {
	OnCastSpell = OnCastSpell,
};





