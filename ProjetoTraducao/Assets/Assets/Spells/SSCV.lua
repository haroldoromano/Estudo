--
--	SCAVENGE
--		Destroy all gold coins	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- No bonuses from this!
	SetMultiplierEffects(false);
	
	-- Loop through each column
	DestroyAllGems(GEM_GOLD,"");
	
	
	-- Allow bonuses again
	SetMultiplierEffects(true);
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SSCV_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	if (CountGems(GEM_GOLD) < 6) then
		return 0;
	end
	
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
SSCV = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






