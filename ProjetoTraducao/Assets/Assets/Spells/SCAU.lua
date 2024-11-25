--
--	CAUTERIZE
--		+1 Healing for each red gem
--		None are destroyed	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- How many!
	local amt = CountGems(GEM_RED);
	EffectOnAllGems(GEM_RED,"RedSparkle");
	
	-- Healing
	Std_Healing(amt,idxCaster);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,GET_TEXT("[SPELL_SCAU_NAME]"));
	
end



------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

   return Std_AISpellcastingChance(0);
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
SCAU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



