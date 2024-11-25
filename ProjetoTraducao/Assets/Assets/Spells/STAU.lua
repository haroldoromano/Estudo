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
	local damage = 8 + GET_MANA_AIR(idxCaster)/10;
	local chance = PERCENTILE_CHANCE_SYNC();
	
	-- Set up message
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",damage);
	
	-- Actual effect
	local textcol = 6;
	local idxEnemy = GET_ENEMY(idxCaster,0);
	if (chance <= 25) then
		textcol = 2;
		SUBTRACT_MANA_EARTH(idxEnemy,damage);
	elseif (chance <= 50) then
		textcol = 0;
		SUBTRACT_MANA_FIRE(idxEnemy,damage);
	elseif (chance <= 75) then
		textcol = 1;
		SUBTRACT_MANA_AIR(idxEnemy,damage);
	else
		textcol = 3;
		SUBTRACT_MANA_WATER(idxEnemy,damage);
	end
	

	-- Special FX on enemy
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,textcol);
		
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_CHAOS,GET_TEXT("[SPELL_STAU_NAME]"));
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

	local idxEnemy = GET_ENEMY(idxCaster,0);
	local evaluation = EVALUATE_BOARD();
	local chance = PERCENTILE_CHANCE_SYNC();
	
	local totalMana = GET_MANA_EARTH(idxEnemy);
	totalMana = totalMana + GET_MANA_FIRE(idxEnemy);
	totalMana = totalMana + GET_MANA_AIR(idxEnemy);
	totalMana = totalMana + GET_MANA_WATER(idxEnemy);
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation >= 30) then
		return 0;
	end
	
	-- specific things to look for
	if (totalMana < 20) then
		return 0;
	end
	if (totalMana < 30 and chance < 75) then
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
STAU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





