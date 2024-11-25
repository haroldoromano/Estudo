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
	local myRoll = PERCENTILE_CHANCE_SYNC();
	local myManaType = GEM_BLUE;
	if (myRoll <= 25) then
		myManaType = GEM_GREEN;
	elseif (myRoll <= 50) then
		myManaType = GEM_YELLOW;
	elseif (myRoll <= 75) then
		myManaType = GEM_RED;
	end
	DestroyAllGems(myManaType ,"");
	
	
	-- Allow bonuses again
	SetMultiplierEffects(true);
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_HIDE,GET_TEXT("[SPELL_SCMA_NAME]"));
	
	
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
SCMA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








