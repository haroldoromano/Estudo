--
--	WORD OF POWER
--		Inflicts lots of status effects	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Status
	Std_InflictStatusEffect(STATUS_EFFECT_FEAR,8,idxCaster);	
	Std_InflictStatusEffect(STATUS_EFFECT_BLIND,6,idxCaster);	
	
	-- Stun
	local numTurns = 3;
	local displayedTurns = numTurns-1;
	local idxEnemy = GET_ENEMY(idxCaster,0);
	MISS_TURNS(idxEnemy,numTurns);
	local damage = 5 + (GET_MANA_FIRE(idxCaster)/8);
	
	-- Set up message
	local msg_turn;
	if (displayedTurns < 2) then
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",displayedTurns);
	else
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN2]",displayedTurns);
	end
	ADD_TEXT_MESSAGE2(msg_turn,2,6);
	
	-- Special Effect
	PLAY_SOUND("snd_stun");	
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,GET_TEXT("[SPELL_SWOP_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(15);
	
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
SWOP = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





