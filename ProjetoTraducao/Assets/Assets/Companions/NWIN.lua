--
--	WINTER
--		Halves starting mana of anybody whose Fire is 15+	
--


------------------------------------------------
--
-- OnStartBattle
--
--    A battle has just started
--    This is called before the first turn
--
local function OnStartBattle(characterIdx)

	local idxEnemy = GET_ENEMY(characterIdx,0);
	
	if (IS_MONSTER(idxEnemy) and GET_SKILL(idxEnemy,SKILL_FIRE) >= 15) then
		SET_MANA_AIR(idxEnemy,GET_MANA_AIR(idxEnemy)/2);
		SET_MANA_EARTH(idxEnemy,GET_MANA_EARTH(idxEnemy)/2);
		SET_MANA_FIRE(idxEnemy,GET_MANA_FIRE(idxEnemy)/2);
		SET_MANA_WATER(idxEnemy,GET_MANA_WATER(idxEnemy)/2);

		ACTIVATE_COMPANION("NWIN");
	end

	return;
end




--	
--		DECLARE TABLE	
--

NWIN = {
   OnStartBattle = OnStartBattle,
};










