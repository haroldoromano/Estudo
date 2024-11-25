--
--	SUBMERGE
--		Doubles my blue - halves their yellow	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	--Effect
	local idxEnemy = GET_ENEMY(idxCaster,0);
	local amt_yellow = GET_MANA_AIR(idxEnemy)/2;
	local amt_blue = GET_MANA_WATER(idxCaster);
	if (2*amt_blue > GET_MAX_MANA_WATER(idxCaster)) then
		amt_blue = GET_MAX_MANA_WATER(idxCaster) - amt_blue;
	end
	
	ADD_MANA_WATER(idxCaster,amt_blue);
	SUBTRACT_MANA_AIR(idxEnemy,amt_yellow);
	
	-- Messages
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt_blue);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_CYAN);
	
	msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",amt_yellow);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy, msg,2,MESSAGE_YELLOW);
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WATER,GET_TEXT("[SPELL_SSBM_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_HIDE,1);
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local modifier = 0;
	local idxEnemy = GET_ENEMY(idxCaster,0);
	
	if (GET_MANA_AIR(idxEnemy) > 10) then
		modifier = modifier + 10;
	end
	if (GET_MANA_AIR(idxEnemy) < 5) then
		modifier = modifier - 10;
	end

	if (GET_MANA_WATER(idxCaster) < 4) then
		modifier = modifier - 10;
	end
	if (GET_MANA_WATER(idxCaster) > 20) then
		modifier = modifier - 10;
	end

	return Std_AISpellcastingChance(modifier);
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
SSBM = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



