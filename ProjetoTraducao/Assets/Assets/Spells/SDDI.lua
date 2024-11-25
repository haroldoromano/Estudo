--
--	DEATH DIVE
--		3 damage +1 damage for each yellow gem in play	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- How much damage
	local amt_damage = 3 + CountGems(GEM_YELLOW);

	EffectOnAllGems(GEM_YELLOW,"YellowSparkle");
	Std_InflictDamage(amt_damage,idxCaster);		

	Std_CastSpellEffect(idxCaster,SPELLFX_AIR,GET_TEXT("[SPELL_SDDI_NAME]"));
	-- Special FX on enemy
	Std_EnemySpellEffect(idxEnemy,SPELLFX_AIR,0);
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numYellow = CountGems(GEM_YELLOW);
	if (numYellow <= 4) then
		return 0;
	end

	return Std_AISpellcastingChance(numYellow * 1.5);
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
SDDI = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




