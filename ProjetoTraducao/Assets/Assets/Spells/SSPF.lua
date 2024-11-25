--
--	SPECTRAL FORCE
--		Enemies 3 turns (+10 damage if blue mana 35+)
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
	local numTurns = 3 + 1;
	
	-- Set up message
	local displayedTurns = numTurns-1;
	local msg;
	if (displayedTurns < 2) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",displayedTurns);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN2]",displayedTurns);
	end
	local doneMsg = false;
	
	local doDamageToo = false;
	if (GET_MANA_WATER(idxCaster) > 35) then
		doDamageToo = true;
	end
	
	-- loop through enemies
	local enemyCounter;
	for enemyCounter = 1,numEnemies do
	
		-- Actual effect
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		MISS_TURNS(idxEnemy,numTurns);
		
		-- Special FX on enemy
		if (doneMsg == false) then
			ADD_TEXT_MESSAGE_TO_CHARACTER2(idxEnemy,msg,2,6);
			doneMsg = true;
		end
		
	end
	
	-- damage?
	if (doDamageToo) then
		Std_InflictDamage(10, idxCaster);
	end
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NECRO,GET_TEXT("[SPELL_SSPF_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_STUN,0);
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local chance = PERCENTILE_CHANCE_SYNC();
	
	if (chance < 15) then
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
SSPF = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








