--
--	VIGIL
--		Put VIGILED status effect on caster
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Status Effects
	local dur = 8 + GET_MANA_WATER(idxCaster)/5;
	Std_ReceiveStatusEffect(STATUS_EFFECT_VIGIL,dur,idxCaster);	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,GET_TEXT("[SPELL_SVIG_NAME]"));
	
	
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
SVIG = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




