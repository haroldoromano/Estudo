--
--	REND
--		5 damage + no end turn	
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
	local damage = 5;
	Std_InflictDamage(damage, idxCaster);
	
	-- No end turn
	EXTRA_TURN(1,0);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SRND_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_WAR,1);
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(10);
	
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
SRND = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



