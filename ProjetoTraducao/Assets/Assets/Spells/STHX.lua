--
--	THROW AXE
--		+1 damage for each skull in play	
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
	local amt_damage = 4 + CountGems(GEM_SKULL) + CountGems(GEM_REDSKULL);

	EffectOnAllGems(GEM_SKULL,"WhiteSparkle");
	EffectOnAllGems(GEM_REDSKULL,"WhiteSparkle");
	Std_InflictDamage(amt_damage,idxCaster);		


	Std_CastSpellEffect(idxCaster,SPELLFX_SPIN,GET_TEXT("[SPELL_STHX_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_SPIN,0);
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numSkulls = CountGems(GEM_GREEN);
	if (numSkulls <= 4) then
		return 0;
	end

	return Std_AISpellcastingChance(numSkulls);
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
STHX = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




