--
--	SOUL SWAP
--		Swaps mana totals	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)
	
	local idxEnemy = GET_ENEMY(idxCaster,0);

	-- Get mana
	local myManaA = GET_MANA_AIR(idxCaster);	
	local myManaE = GET_MANA_EARTH(idxCaster);	
	local myManaF = GET_MANA_FIRE(idxCaster);	
	local myManaW = GET_MANA_WATER(idxCaster);	
	
	local theirManaA = GET_MANA_AIR(idxEnemy );	
	local theirManaE = GET_MANA_EARTH(idxEnemy );	
	local theirManaF = GET_MANA_FIRE(idxEnemy );	
	local theirManaW = GET_MANA_WATER(idxEnemy );	
	
	-- Spell Cost
	myManaE = myManaE - 6;
	myManaA = myManaA - 12;
	myManaW = myManaW - 18;

	-- Zero mana
	SET_MANA_AIR(idxCaster,0);
	SET_MANA_EARTH(idxCaster,0);
	SET_MANA_FIRE(idxCaster,0);
	SET_MANA_WATER(idxCaster,0);

	SET_MANA_AIR(idxEnemy ,0);
	SET_MANA_EARTH(idxEnemy ,0);
	SET_MANA_FIRE(idxEnemy ,0);
	SET_MANA_WATER(idxEnemy ,0);

	-- Add back
	ADD_MANA_AIR(idxCaster,theirManaA );
	ADD_MANA_EARTH(idxCaster,theirManaE );
	ADD_MANA_FIRE(idxCaster,theirManaF );
	ADD_MANA_WATER(idxCaster,theirManaW );

	ADD_MANA_AIR(idxEnemy ,myManaA );
	ADD_MANA_EARTH(idxEnemy ,myManaE );
	ADD_MANA_FIRE(idxEnemy ,myManaF );
	ADD_MANA_WATER(idxEnemy ,myManaW );

	-- An extra turn
	EXTRA_TURN(1,0);
	NOTIFY_OF_FREE_SPELL();
	
	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,GET_TEXT("[SPELL_SSSW_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_SYMBOL,0);
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local idxEnemy = GET_ENEMY(idxCaster,0);
	local myManaTotal = GET_MANA_AIR(idxCaster) +
			GET_MANA_EARTH(idxCaster) +
			GET_MANA_FIRE(idxCaster) +
			GET_MANA_WATER(idxCaster);
	local theirManaTotal = GET_MANA_AIR(idxEnemy ) +
			GET_MANA_EARTH(idxEnemy ) +
			GET_MANA_FIRE(idxEnemy ) +
			GET_MANA_WATER(idxEnemy );

	if (myManaTotal > theirManaTotal) then
		return 0;
	end

	return Std_AISpellcastingChance(2*(theirManaTotal-myManaTotal));
end

------------------------------------------------
--
-- IsCastSpellLegal
--
--    Called to check if a spell may be cast
--    Returns 1 if it can, 0 if it cannot
--
local function IsCastSpellLegal(idxCaster)

	return 1;
end



--	
--		DECLARE TABLE	
--

SSSW = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








