--
--	NEW SPELL
--		Spell Description	
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
	
	-- Gem effect
	local numGems = CountGems(GEM_YELLOW);
	DeleteAllGems(GEM_YELLOW,"YellowSparkle");
	ADD_LIFE(idxCaster, numGems );

	-- Add to the morale skill
	ADD_TEMP_SKILL(idxCaster,SKILL_MORALE,numGems );
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDMORALE]",numSkulls);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_PURPLE);
	
	-- Allow bonuses again
	SetMultiplierEffects(true);
	
	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SSWM_NAME]"));
	Std_CasterSpellEffect(idxCaster,SPELLFX_HEALING,0);

	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local bonus = CountGems(GEM_YELLOW);
	if (bonus <= 5) then
		bonus = -20;
	else
		bonus = bonus*3;
	end
	return Std_AISpellcastingChance(bonus);
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

SSWM = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};











