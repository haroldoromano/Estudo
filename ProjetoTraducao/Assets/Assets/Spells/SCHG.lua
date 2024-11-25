--
--	CHARGE
--		Destroy Row & Damage opponent	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Charge the mana first
	HANDLE_SPELL_COST(idxCaster);

	-- Which Row?
	local y = GET_INPUT_DATA(0);
	
	-- No bonuses from this!
	SET_EXTRATURN_CHANCE_ENABLED(0);
	SET_WILDCARD_CHANCE_ENABLED(0);
	SET_DAMAGE_MULTIPLIER_ENABLED(0);
	
	-- Loop through each column
	local x;
	for x = 1,8 do
	
		DESTROY_GEM(x,y);
		
	end
	
	-- Damage opponent
	local numEnemies = GET_NUM_ENEMIES(idxCaster);
	local damage = 5;
	
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
		ADD_EFFECT_TO_CHARACTER(idxEnemy,"RedSkull");
		if (doneMsg == false) then
			ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,6);
			doneMsg = true;
		end
		
	end
	
	
	
	-- Allow bonuses again
	SET_EXTRATURN_CHANCE_ENABLED(1);
	SET_WILDCARD_CHANCE_ENABLED(1);
	SET_DAMAGE_MULTIPLIER_ENABLED(1);
	
	
	-- Special FX on caster
	PLAY_SOUND("snd_spellnature");
	ADD_EFFECT_TO_CHARACTER(idxCaster,"Spell0");
	ADD_EFFECT_TO_CHARACTER(idxCaster,"Spell1");
	
	-- Spell Name
	local msg = GET_TEXT("[SPELL_SCHG_NAME]");
	ADD_TEXT_MESSAGE(msg,2,6);

	
end

local function EvaluateRows()
	local bestRow = 1;
	local numSkulls = 0;
	local currSkulls = 0;
	local x;
	local y;
	
	-- Find the row with the best number of skulls
	for y = 1,8 do
		currSkulls = 0;
		
		for x = 1,8 do
			if (GET_GEM(x,y) == 5) then
				currSkulls = currSkulls+1;
			elseif (GET_GEM(x,y) == 15) then
				currSkulls = currSkulls+5;
			end
		end
		
		if (currSkulls >= numSkulls) then
			numSkulls = currSkulls;
			bestRow = y;
		end
		
	end
	
	-- Store it in case we cast
	SET_INPUT_DATA(0,bestRow);
	
	-- Try not to cast if there aren't many skulls
	if (numSkulls < 4) then
		return -20;
	end
		
	-- If we have lots of skulls - it is good
	return numSkulls*5;
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
	local rowValue = EvaluateRows();
	
	-- Standard chances
	if (chance < 50 - rowValue) then
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
SCHG = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



