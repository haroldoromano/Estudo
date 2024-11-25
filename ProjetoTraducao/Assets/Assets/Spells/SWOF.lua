--
--	WALL OF FIRE
--		Inflicts "Wall of Fire" on the caster until it runs out	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- W.O.F.
	Std_ReceiveStatusEffect(STATUS_EFFECT_WALLOFFIRE,0,idxCaster);	

	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_FIREBALL,GET_TEXT("[SPELL_SWOF_NAME]"));
	
	
end



------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

   if (HAS_STATUS_EFFECT(idxCaster,STATUS_EFFECT_WALLOFFIRE)) then
	return 0;
   end

   local red_mana = GET_MANA_FIRE(idxCaster);
   local bonus = 0;
   if (red_mana > 14) then
	bonus = 20;
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
SWOF = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






