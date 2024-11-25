--
--	CHIVALRY
--		Remove all status, max out all mana	
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

	-- Max out mana
	SET_MANA_AIR(idxCaster, GET_MAX_MANA_AIR(idxCaster));
	SET_MANA_EARTH(idxCaster, GET_MAX_MANA_EARTH(idxCaster));
	SET_MANA_FIRE(idxCaster, GET_MAX_MANA_FIRE(idxCaster));
	SET_MANA_WATER(idxCaster, GET_MAX_MANA_WATER(idxCaster));

	SET_MANA_AIR(idxEnemy , GET_MAX_MANA_AIR(idxEnemy ));
	SET_MANA_EARTH(idxEnemy , GET_MAX_MANA_EARTH(idxEnemy ));
	SET_MANA_FIRE(idxEnemy , GET_MAX_MANA_FIRE(idxEnemy ));
	SET_MANA_WATER(idxEnemy , GET_MAX_MANA_WATER(idxEnemy ));

	NOTIFY_OF_FREE_SPELL();

	-- Remove status effects
	CLEAR_STATUS_EFFECTS(idxCaster);
	CLEAR_STATUS_EFFECTS(idxEnemy );
	MISS_TURNS(idxCaster,0);
	MISS_TURNS(idxEnemy ,0);
	

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_GOOD,GET_TEXT("[SPELL_SCHV_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_GOOD,0);
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(-15);
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

SCHV = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};














