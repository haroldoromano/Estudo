--
--	WILD LORE
--		Destroys all yellow & blue gems - 1 XP for each	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Change it
	local amt_xp = CountGems(GEM_YELLOW);
	amt_xp = amt_xp + CountGems(GEM_BLUE);
	DeleteAllGems(GEM_YELLOW,"YellowSparkle");
	DeleteAllGems(GEM_BLUE,"CyanSparkle");
	
	-- Add XP
	if (amt_xp > 0) then	
		ADD_XP(idxCaster,amt_xp);		
	end
	
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SWLO_NAME]"));
	
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
SWLO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



