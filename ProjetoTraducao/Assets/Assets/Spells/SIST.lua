--
--	IRON STRIKE
--		Destroys all green gems in an EXPLOSION	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Charge the mana first
	HANDLE_SPELL_COST(idxCaster);

	
	-- Find them all
	SetMultiplierEffects(false);
	ExplodeAllGems(GEM_GREEN, "GreenSparkle");
	SetMultiplierEffects(true);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SIST_NAME]"));
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	
	local numGreen = CountGems(GEM_GREEN);
	if (numGreen <= 4) then
		return 0;
	end

	local evaluation = EVALUATE_BOARD();
	local chance = PERCENTILE_CHANCE_SYNC() - numGreen*2;
	
	if (evaluation < 25 and chance < 75) then
		return 1;
	end
	if (evaluation < 30 and chance < 50) then
		return 1;
	end
	

	return 0;
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
SIST = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





