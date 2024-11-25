--
--	STOMP
--		Destroy all green gems & enemies miss a turn
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local numTurns = 2;
	
	-- Set up message
	local displayedTurns = numTurns-1;
	local msg_turn;
	local msg_damage;
	if (displayedTurns < 2) then
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",displayedTurns);
	else
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN2]",displayedTurns);
	end
	local doneMsg = false;
	
	-- No bonuses from this!
	SET_EXTRATURN_CHANCE_ENABLED(0);
	SET_WILDCARD_CHANCE_ENABLED(0);
	SET_DAMAGE_MULTIPLIER_ENABLED(0);
	
	-- Loop through each grid
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == 1) then
				DESTROY_GEM(x,y);
			end
		end
	end
	
	-- Allow bonuses again
	SET_EXTRATURN_CHANCE_ENABLED(1);
	SET_WILDCARD_CHANCE_ENABLED(1);
	SET_DAMAGE_MULTIPLIER_ENABLED(1);
	
	-- loop through enemies
	local numEnemies = GET_NUM_ENEMIES(idxCaster);
	local enemyCounter;
	for enemyCounter = 1,numEnemies do
	
		-- Actual effect
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		MISS_TURNS(idxEnemy,numTurns);
		
		-- Special FX on enemy
		ADD_EFFECT_TO_CHARACTER(idxEnemy,SPELLFX_STONE,0);
		if (doneMsg == false) then
			PLAY_SOUND("snd_redskull");
			ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg_turn,2,6);
			doneMsg = true;
		end
		
	end
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SSTO_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_STUN,1);
	
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
	
	local numGreenGems = 0;
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == 1) then
				numGreenGems = numGreenGems+1;
			end
		end
	end
	chance = chance + numGreenGems;
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	-- specific things to look for
	if (numGreenGems < 6) then
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
SSTO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




