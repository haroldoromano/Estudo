--
--	REGENERATION
--		Heals the caster & doesn't end the turn
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- if we change the cost (7) or the effect (4) we need to rewrite this bit!
	local mana_each = 7;
	local amt_each = 4;
	
	local amt = amt_each;
	local healing_required = GET_MAX_LIFE(idxCaster) - GET_LIFE(idxCaster);
	
	if (IS_MONSTER(idxCaster)) then
		-- check for multiple castings
		while (GET_MANA_WATER(idxCaster) >= mana_each*2 and healing_required >= amt_each*2) do
			SUBTRACT_MANA_WATER(idxCaster,mana_each);
			amt = amt + amt_each;
			healing_required = healing_required - amt_each;
		end
	end

	ADD_LIFE(idxCaster,amt);
	EXTRA_TURN(1,0);
	
	local msg;
	if (amt == 1) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING1]",amt);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING2]",amt);
	end
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,6);
	
	Std_CastSpellEffect(idxCaster,SPELLFX_HEALING,GET_TEXT("[SPELL_SRGN_NAME]"));
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local dmg = GET_MAX_LIFE(idxCaster) - GET_LIFE(idxCaster);
	if (dmg >= 4) then
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
SRGN = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








