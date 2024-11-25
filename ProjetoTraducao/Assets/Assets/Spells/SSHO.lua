--
--	SINKHOLE
--		Doubles enemy green, halves other colors
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Status Effects
	local idxEnemy = GET_ENEMY(idxCaster,0);
	Std_GridSpellEffect(4,4,SPELLFX_FEAR,1);
	
	-- Double green
	ADD_MANA_EARTH(idxEnemy,GET_MANA_EARTH(idxEnemy));
	SUBTRACT_MANA_FIRE(idxEnemy,GET_MANA_FIRE(idxEnemy)/2);
	SUBTRACT_MANA_AIR(idxEnemy,GET_MANA_AIR(idxEnemy)/2);
	SUBTRACT_MANA_WATER(idxEnemy,GET_MANA_WATER(idxEnemy)/2);

	-- Message
	local msg = GET_TEXT("[SPELL_EFFECT_SINKHOLE]");		
	ADD_TEXT_MESSAGE2(msg,2,6);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SSHO_NAME]"));
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
	
	if (GET_MANA_FIRE(idxEnemy) > 5) then
		modifier = modifier + 10;
	end
	if (GET_MANA_AIR(idxEnemy) > 5) then
		modifier = modifier + 10;
	end
	if (GET_MANA_WATER(idxEnemy) > 5) then
		modifier = modifier + 10;
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
SSHO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



