--
--	PALADINS AURA
--		Adds +2 of each mana per turn	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)
	
	-- Receive Paladins Aura effect
	local duration = 8 + GET_MANA_AIR(idxCaster)/5;
	Std_ReceiveStatusEffect(STATUS_EFFECT_PALADINSAURA,duration,idxCaster);

	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,GET_TEXT("[SPELL_SPAU_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
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
--		DECLARE TABLE	
--

SPAU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};











