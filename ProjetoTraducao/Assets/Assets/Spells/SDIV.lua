--
--	DIVINE RIGHT
--		Destroy all purple stars	
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
	DestroyAllGems(GEM_STAR,"");
	
	
	-- Allow bonuses again
	SetMultiplierEffects(true);
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_GOOD,GET_TEXT("[SPELL_SDIV_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numGems = CountGems(GEM_STAR);
	if (numGems < 8) then
		return 0;
	end
	
	return Std_AISpellcastingChance(numGems);
	
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
SDIV = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




