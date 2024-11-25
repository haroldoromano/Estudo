--
--	TAIL WHIP
--		10 damage + no end turn	
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
	local damage = 10;
	Std_InflictDamage(damage, idxCaster);
	
	-- No end turn
	EXTRA_TURN(1,0);

	Std_EnemySpellEffect(idxCaster,SPELLFX_CHAOS,1);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPIN,GET_TEXT("[SPELL_STWH_NAME]"));
		
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
STWH = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






