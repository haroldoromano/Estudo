--
--	NEW SPELL
--		Spell Description	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Damage
	Std_InflictDamage(GET_MANA_WATER(idxCaster),idxCaster);

	-- Drain
	SET_MANA_WATER(idxCaster,0);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_FROST,GET_TEXT("[SPELL_SBRI_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_FROST,0);
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(50);
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

SBRI = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};












