--
--	FIRE SHIELD
--		Put FIRESHIELDED status effect on caster
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
	local dur = 8 + GET_MANA_FIRE(idxCaster)/3;
	Std_ReceiveStatusEffect(STATUS_EFFECT_FIRESHIELD,dur,idxCaster);	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,GET_TEXT("[SPELL_SFSH_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local modifier = 2*GET_MANA_FIRE(idxCaster);
	
	return Std_AISpellcastingChance(modifier);
	
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
SFSH = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





