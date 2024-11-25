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
	local dmg = GET_MANA_FIRE(idxCaster);
	Std_InflictDamage(dmg,idxCaster);	
	
	-- Poison
	Std_InflictStatusEffect(STATUS_EFFECT_POISON,8,idxCaster);	

	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_DEFAULTGFXONLY,GET_TEXT("[SPELL_SDST_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_POISON,1);
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(GET_MANA_FIRE(idxCaster)*2);
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

SDST  = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};










