--
--	GEMBERRY
--		Healing	 the caster
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local amt = 5 + (GET_MANA_WATER(idxCaster)/4);
	ADD_LIFE(idxCaster,amt);
	
	local msg;
	if (amt == 1) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING1]",amt);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING2]",amt);
	end
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,6);

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_HEALING,GET_TEXT("[SPELL_SGEM_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

   if (GET_LIFE(idxCaster) >= GET_MAX_LIFE(idxCaster)-5) then
	return 0;
   end
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
SGEM = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};












