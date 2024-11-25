--
--	BONE AVATAR
--		Adds points from Green Mana to a random skill	, green mana -> 0
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)
	
	local mana = GET_MANA_EARTH(idxCaster);	
	SET_MANA_EARTH(idxCaster,0);	
	
	ADD_TEMP_SKILL(idxCaster,SKILL_BATTLE,mana );
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDBATTLE]",mana);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_WHITE);

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NECRO,GET_TEXT("[SPELL_SBAV_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(GET_MANA_EARTH(idxCaster)-10);
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

SBAV = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};











