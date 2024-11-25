--
--	EAT SKULLS
--		Destroys Skulls
--		Each one gives me a point of healing	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local numSkulls = CountGems(GEM_SKULL) + CountGems(GEM_REDSKULL);
	
	-- Loop through each column
	DeleteAllGems(GEM_SKULL,"RedSparkle");
	DeleteAllGems(GEM_REDSKULL,"RedSparkle");
	
	-- Add to the battle skill
	ADD_TEMP_SKILL(idxCaster,SKILL_BATTLE,numSkulls);
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDBATTLE]",numSkulls);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_WHITE);
	
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NECRO,GET_TEXT("[SPELL_SESK_NAME]"));
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numSkulls = CountGems(GEM_SKULL) + CountGems(GEM_REDSKULL);
	
	if (numSkulls < 4) then
		return 0;
	end
	
	return Std_AISpellcastingChance(numSkulls*2);
	
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
SESK = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








