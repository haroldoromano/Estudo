--
--	STUN
--		Damage opponent & miss 1 turn	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)


	local numEnemies = GET_NUM_ENEMIES(idxCaster);
	local numTurns = 2;
	local damage = 5 + (GET_MANA_FIRE(idxCaster)/8);
	
	-- Set up message
	local displayedTurns = numTurns-1;
	local msg_turn;
	local msg_damage;
	if (displayedTurns < 2) then
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",displayedTurns);
	else
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN2]",displayedTurns);
	end
	if (damage < 2) then
	   msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE1]",damage);
	else
	   msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE2]",damage);
	end
	local doneMsg = false;
	
	-- loop through enemies
	local enemyCounter;
	for enemyCounter = 1,numEnemies do
	
		-- Actual effect
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		MISS_TURNS(idxEnemy,numTurns);
		SUBTRACT_LIFE(idxEnemy,damage,idxCaster);
		Std_GridSpellEffect(4,4,SPELLFX_STONE,1);
			
		-- Special FX on enemy
		if (doneMsg == false) then
			ADD_TEXT_MESSAGE2(msg_turn,2,6);
			ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg_damage,2,6);
			Std_EnemySpellEffect(idxCaster,SPELLFX_STUN,1);
			doneMsg = true;
		end
		
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SSTU_NAME]"));

end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(10);
	
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
SSTU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




















