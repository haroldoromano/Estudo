--
--	SENSE BLOOD
--		Destroys Red & Blue Gems, Add their total as XP	
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
	local amt_xp = 2*CountGems(GEM_RED);
	amt_xp = amt_xp + 2*CountGems(GEM_BLUE);
	DeleteAllGems(GEM_RED,"RedSparkle");
	DeleteAllGems(GEM_BLUE,"CyanSparkle");
	
	-- Add XP
	if (amt_xp > 0) then	
		ADD_XP(idxCaster,amt_xp);		
	end
	
	Std_CastSpellEffect(idxCaster,SPELLFX_SPIN,GET_TEXT("[SPELL_SSBD_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
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
--		DECLARE TABLE	
--

SSBD = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};









