--
--	WALL OF THORNS
--		Inflicts "Wall of thorns" on the caster until it runs out	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- W.O.T.
	Std_ReceiveStatusEffect(STATUS_EFFECT_WALLOFTHORNS,0,idxCaster);	

	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_NATURE,GET_TEXT("[SPELL_SWOT_NAME]"));
	Std_CasterSpellEffect(idxCaster,SPELLFX_SYMBOL,1);
	
	
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
SWOT = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




