--
--	SNEAK ATTACK
--		Does 3 damage and turn never ends	
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
	local amt_damage = 3;
	Std_InflictDamage(amt_damage, idxCaster);
	
	-- Another Turn
	EXTRA_TURN(1,0);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_CHAOS,GET_TEXT("[SPELL_SSNK_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_CHAOS,0);
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return 1;
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
SSNK = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




