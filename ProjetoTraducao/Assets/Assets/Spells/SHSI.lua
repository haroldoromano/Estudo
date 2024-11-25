--
--	HEAT SINK
--		-8 to enemy red mana, +8 to yours!
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Find amounts
	local idxEnemy = GET_ENEMY(idxCaster,0);
	local amt = GET_MANA_FIRE(idxEnemy);
	if (amt > 8) then
		amt = 8;
	end
	
	-- Drain enemy
	SUBTRACT_MANA_FIRE(idxEnemy,amt);
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",amt);		
	ADD_EFFECT_TO_CHARACTER(idxEnemy,"RedSparkle");
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,MESSAGE_RED);
	
	-- Give it to ME
	ADD_MANA_FIRE(idxCaster,amt);
	msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt);	
	ADD_EFFECT_TO_CHARACTER(idxCaster,"RedSparkle");
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster,msg,2,MESSAGE_RED);
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SHSI_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_HIDE,0);
	
	
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
SHSI = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};







