--
--	ENTANGLE
--		Opponent misses turns	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Calculate effect
	local numEnemies = GET_NUM_ENEMIES(idxCaster);
	local numTurns = 2 + (GET_MANA_EARTH(idxCaster)/20);
	
	-- Set up message
	local displayedTurns = numTurns-1;
	local msg;
	if (displayedTurns < 2) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",displayedTurns);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN2]",displayedTurns);
	end
	local doneMsg = false;
	
	-- loop through enemies
	local enemyCounter;
	for enemyCounter = 1,numEnemies do
	
		-- Actual effect
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		MISS_TURNS(idxEnemy,numTurns);
		
		-- Special FX on enemy
		Std_EnemySpellEffect(idxCaster,SPELLFX_WEB,1);
		if (doneMsg == false) then
			ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,6);
			doneMsg = true;
		end
		
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NATURE,GET_TEXT("[SPELL_SENT_NAME]"));
	
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
SENT = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






