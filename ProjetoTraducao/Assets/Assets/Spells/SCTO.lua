--
--	CHILL TOUCH
--		-2 Mana of each color to enemy... +5 Green mana to me	
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
	local amt_manadrain = 3;
	local amt_manaadd = 5;
	local idxEnemy = GET_ENEMY(idxCaster,0);

	-- Perform main effect
	SUBTRACT_MANA_AIR(idxEnemy,amt_manadrain);
	SUBTRACT_MANA_EARTH(idxEnemy,amt_manadrain);
	SUBTRACT_MANA_FIRE(idxEnemy,amt_manadrain);
	SUBTRACT_MANA_WATER(idxEnemy,amt_manadrain);
	ADD_MANA_EARTH(idxCaster,amt_manaadd);

	-- Messages	
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt_manaadd);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_GREEN);
	
	msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",amt_manadrain);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy, msg,2,MESSAGE_WHITE);
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WATER,GET_TEXT("[SPELL_SCTO_NAME]"));
	
	-- Special FX on enemy
	Std_EnemySpellEffect(idxCaster,SPELLFX_FROST,1);
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	if (GET_MANA_EARTH(idxCaster) > 10) then
		return 0;
	end
	
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
SCTO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






