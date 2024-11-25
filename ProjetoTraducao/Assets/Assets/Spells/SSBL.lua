--
--	Singing Blades
--		-4 all mana when enemy hit	
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
	local dur = 5 + GET_MANA_AIR(idxCaster)/2;
	Std_ReceiveStatusEffect(STATUS_EFFECT_SINGINGBLADES,dur,idxCaster);	
	Std_EnemySpellEffect(idxCaster,SPELLFX_SPIN,0);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPIN,GET_TEXT("[SPELL_SSBL_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	if (HAS_STATUS_EFFECT(idxCaster,STATUS_EFFECT_SINGINGBLADES)) then
		return -10;
	end
	
	return Std_AISpellcastingChance(25);
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

SSBL = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








