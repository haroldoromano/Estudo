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
	local damage = 5 + GET_MANA_FIRE(idxCaster)/8;
	local charx	= GET_CHARACTER_X(idxCaster);
	local chary	= GET_CHARACTER_Y(idxCaster);
	
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
		local enemyx	= GET_CHARACTER_X(idxEnemy);
		local enemyy	= GET_CHARACTER_Y(idxEnemy);
		ADD_LIGHTNING(charx,chary,enemyx,enemyy,1.2);
		if (doneMsg == false) then
			ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,6);
			doneMsg = true;
		end
		
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SZAP_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_SPARKLE,0);
	PLAY_SOUND("snd_damage");
	
	
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
	
	-- bias
	chance  = chance - GET_MANA_FIRE(idxCaster);
	evaluation = evaluation - GET_MANA_FIRE(idxCaster)/5;
	
	if (evaluation < 28 and chance < 75) then
		return 1;
	end
	if (evaluation < 32 and chance < 33) then
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
SZAP = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



