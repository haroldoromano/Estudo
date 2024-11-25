--
--	FIRE BOLT
--		4 damage +1 per 8 Red Mana	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Calculate effect
	local damage = 4 + (GET_MANA_FIRE(idxCaster)/8);
	Std_InflictDamageWithAnimEffect(damage, idxCaster,"SpellFireball");
	local idxEnemy = GET_ENEMY(idxCaster, 0);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SFBO_NAME]"));
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local modifier = 2*GET_MANA_FIRE(idxCaster);
	
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
SFBO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





