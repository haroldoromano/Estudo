--
--	BLOODLUST
--		Turn other mana into RED mana	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Calculate effect
	local amt = 12;
	
	-- Set up message
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,0);
	
	-- Actual effect
	ADD_MANA_FIRE(idxCaster, amt);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SBLU_NAME]"));
	
	
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
SBLU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};


