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
	Std_InflictDamage(GET_MANA_AIR(idxCaster),idxCaster);

	-- Drain
	SET_MANA_AIR(idxCaster,0);
	
	-- Disease
	local dur = 20;
	Std_InflictStatusEffect("EDIS",dur,idxCaster);	

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_DEFAULTGFXONLY,GET_TEXT("[SPELL_SBRP_NAME]"));
	
	-- Special FX on enemy
	Std_EnemySpellEffect(idxCaster,SPELLFX_DISEASE,1);
	
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

SBRP = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};

















