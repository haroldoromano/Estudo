--
--	SPIT POISON
--		Blinds & Poisons an opponent for 3 turns (+1 per 12 blue mana)	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	--Effect
	local duration = 3 + GET_MANA_WATER(idxCaster)/12;
	Std_InflictStatusEffect(STATUS_EFFECT_BLIND,duration,idxCaster);	
	Std_InflictStatusEffect(STATUS_EFFECT_POISON,duration,idxCaster);	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SSPT_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_POISON,1);
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local modifier = 0;
	
	local idxEnemy = GET_ENEMY(idxCaster,0);
	if (HAS_STATUS_EFFECT(idxEnemy,STATUS_EFFECT_BLIND)) then
		modifier = modifier - 15;
	end

	return Std_AISpellcastingChance(modifier);
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
--     DECLARE TABLE
--
SSPT = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





