--
--	THUMP
--		Damage opponent	
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
	local damage = 10;
	
	-- Set up message
	local msg;
	if (damage < 2) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE1]",damage);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE2]",damage);
	end
	local doneMsg = false;
	
	-- loop through enemies
	local enemyCounter;
	for enemyCounter = 1,numEnemies do
	
		-- Actual effect
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		SUBTRACT_LIFE(idxEnemy,damage,idxCaster);
		
		-- Special FX on enemy
		if (doneMsg == false) then
			ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,6);
			doneMsg = true;
		end
		
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_STHU_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_STONE,1);
	
	
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
	
	if (evaluation < 25 and chance < 75) then
		return 1;
	end
	if (evaluation < 30 and chance < 33) then
		return 1;
	end

	return 0;
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
STHU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




