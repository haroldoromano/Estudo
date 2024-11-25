--
--	SWOOP
--		Drains the opponent of Yellow Mana	
--		If My own Yellow Mana is 14+, then no end turn
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Loop through each column
	local numEnemies = GET_NUM_ENEMIES(idxCaster);
	for enemyCounter = 1,numEnemies do
	
		-- Actual effect
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		local amt = GET_MANA_AIR(idxEnemy)/2;
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",amt);
		
		SUBTRACT_MANA_AIR(idxEnemy,amt,idxCaster);
		
		-- Special FX on enemy
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,1);
		
	end
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_AIR,GET_TEXT("[SPELL_SSWP_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_HIDE,0);

	-- An extra turn, perhaps??
	if (GET_MANA_AIR(idxCaster) >= 14) then
		EXTRA_TURN(1,0);
	end
	
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
	
	-- How much air do enemies have?
	local amt_air = 0;
	local numEnemies = GET_NUM_ENEMIES(idxCaster);
	for enemyCounter = 1,numEnemies do
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		amt_air = amt_air + GET_MANA_AIR(idxEnemy);		
	end
	if (amt_air < 6) then
		return 0;
	end
	
	-- Standard chances
	if (chance < 50 - amt_air) then
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
SSWP = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




