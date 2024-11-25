--
--	HASTE
--		Put HASTED status effect on caster
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
	local dur = 10 + GET_MANA_AIR(idxCaster)/5;
	Std_ReceiveStatusEffect(STATUS_EFFECT_HASTE,dur,idxCaster);	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NATURE,GET_TEXT("[SPELL_SHAS_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	if (HAS_STATUS_EFFECT(idxCaster,STATUS_EFFECT_HASTE)) then
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
SHAS = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



