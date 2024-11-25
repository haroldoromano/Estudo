--
--	ENRAGE
--		Inflicts "Enraged" on the caster for 6 turns + 1 per 4 Red Mana	
--
	


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)
	local msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",1);
	local idxEnemy = GET_ENEMY(idxCaster,0);

	--ADD_TEXT_MESSAGE2(msg_turn,2,0);

	EXTRA_TURN(1,0);

	-- Enraged
	local dur = 8;
	Std_ReceiveStatusEffect(STATUS_EFFECT_ENRAGED,dur,idxCaster);	

	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SENR_NAME]"));
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local evaluation = EVALUATE_BOARD();
	local chance = PERCENTILE_CHANCE_SYNC();
	
	if (HAS_STATUS_EFFECT(idxCaster,STATUS_EFFECT_ENRAGED)) then
		return 0;
	end
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	return 1;
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
SENR = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};


















