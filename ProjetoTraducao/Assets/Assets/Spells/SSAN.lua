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

	local rMana = GET_RANDOM_SYNC(0,3);
	local amt = 5;

	if(rMana == 0)then
		ADD_TEMP_RESISTANCE(idxCaster,MANA_GREEN,amt );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDEARTHRES]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_GREEN);

	elseif(rMana == 1)then
		ADD_TEMP_RESISTANCE(idxCaster,MANA_RED,5);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDFIRERES]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_RED);

	elseif(rMana == 2) then
		ADD_TEMP_RESISTANCE(idxCaster,MANA_BLUE,5);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDWATERRES]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_CYAN);

	else 
		ADD_TEMP_RESISTANCE(idxCaster,MANA_YELLOW,5);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDAIRRES]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_YELLOW);

	end

	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_WATER,GET_TEXT("[SPELL_SSAN_NAME]"));
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(5);
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

SSAN = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};

























