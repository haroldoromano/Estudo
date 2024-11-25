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
		
	local numGems = CountGems(GEM_BLUE);
	DestroyAllGems(GEM_BLUE,"");

	ADD_TEMP_SKILL(idxCaster,SKILL_WATER,numGems );
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDWATER]",numGems );
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_CYAN);

	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_FROST,GET_TEXT("[SPELL_SBNW_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local bonus = CountGems(GEM_BLUE);
	if (bonus < 5) then
		return 0;
	end
	return Std_AISpellcastingChance(3*bonus);
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

SBNW  = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};










