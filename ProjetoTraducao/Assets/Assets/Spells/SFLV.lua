--
--	FLAMING AVATAR
--		Adds points from Red Mana to a random skill	, red mana -> 0
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)
	
	local mana = GET_MANA_FIRE(idxCaster);	
	local skill = GET_RANDOM_SYNC(0,6);
	SET_MANA_FIRE(idxCaster,0);	
	
	if (skill == SKILL_EARTH) then
		ADD_TEMP_SKILL(idxCaster,skill ,mana );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDEARTH]",mana);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_GREEN);

	elseif (skill == SKILL_FIRE) then
		ADD_TEMP_SKILL(idxCaster,skill ,mana );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDFIRE]",mana);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_RED);

	elseif (skill == SKILL_AIR ) then
		ADD_TEMP_SKILL(idxCaster,skill ,mana );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDAIR]",mana);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_YELLOW);

	elseif (skill == SKILL_WATER ) then
		ADD_TEMP_SKILL(idxCaster,skill ,mana );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDWATER]",mana);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_CYAN);

	elseif (skill == SKILL_BATTLE ) then
		ADD_TEMP_SKILL(idxCaster,skill ,mana );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDBATTLE]",mana);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_WHITE);

	elseif (skill == SKILL_CUNNING ) then
		ADD_TEMP_SKILL(idxCaster,skill ,mana );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDCUNNING]",mana);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_ORANGE);

	elseif (skill == SKILL_MORALE ) then
		ADD_TEMP_SKILL(idxCaster,skill ,mana );
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDMORALE]",mana);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_PURPLE);
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_GOOD,GET_TEXT("[SPELL_SFLV_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(GET_MANA_FIRE(idxCaster)-10);
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

SFLV = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};












