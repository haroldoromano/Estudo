--
--	COURAGE
--		Removes all status effects on hero
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Remove on me
	CLEAR_STATUS_EFFECTS(idxCaster);
	ADD_EFFECT_TO_CHARACTER(idxCaster,"GreenSparkle");

	-- End of turn?
	if (GET_MANA_WATER(idxCaster) >= 10) then
		EXTRA_TURN(1,0);
	end

		-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_GOOD,GET_TEXT("[SPELL_SCOU_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

   local bonus = 0;
   if (GET_NUM_STATUS_EFFECTS(idxCaster)) then
	bonus = -50;
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
--     DECLARE TABLE
--
SCOU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




