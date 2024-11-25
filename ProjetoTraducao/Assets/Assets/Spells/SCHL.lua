--
--	CHALLENGE
--		Put CHALLENGED status effect on both combatants
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
	Std_InflictStatusEffect(STATUS_EFFECT_CHALLENGED,6,idxCaster);
	Std_ReceiveStatusEffect(STATUS_EFFECT_CHALLENGED,6,idxCaster);	
	
	-- Extra turn?
	if (GET_MANA_AIR(idxCaster) >= 15) then
		EXTRA_TURN(1,0);
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_STUN,GET_TEXT("[SPELL_SCHL_NAME]"));

	Std_EnemySpellEffect(idxCaster,SPELLFX_STUN,0);
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	if (HAS_STATUS_EFFECT(idxCaster,STATUS_EFFECT_CHALLENGED)) then
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
SCHL = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



