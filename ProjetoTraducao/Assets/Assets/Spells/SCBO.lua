--
--	Chaos Bolt
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

	-- Find a random mana reserve
	local myRoll = PERCENTILE_CHANCE_SYNC();
	local myManaType = MANA_BLUE;
	if (myRoll <= 25) then
		myManaType = MANA_GREEN;
	elseif (myRoll <= 50) then
		myManaType = MANA_YELLOW;
	elseif (myRoll <= 75) then
		myManaType = MANA_RED;
	end

	-- Do damage
	local damage = 0;
	if (myManaType == MANA_BLUE) then
		damage = GET_MANA_WATER(idxCaster);
		SET_MANA_WATER(idxCaster,0);
	elseif (myManaType == MANA_GREEN) then
		damage = GET_MANA_EARTH(idxCaster);
		SET_MANA_EARTH(idxCaster,0);
	elseif (myManaType == MANA_YELLOW) then
		damage = GET_MANA_AIR(idxCaster);
		SET_MANA_AIR(idxCaster,0);
	else 
		damage = GET_MANA_FIRE(idxCaster);
		SET_MANA_FIRE(idxCaster,0);
	end
	Std_InflictDamage(damage,idxCaster);

	-- Lightning Effect
	local idxEnemy = GET_ENEMY(idxCaster,0);
	local charx	= GET_CHARACTER_X(idxCaster);
	local chary	= GET_CHARACTER_Y(idxCaster);
	local enemyx= GET_CHARACTER_X(idxEnemy);
	local enemyy= GET_CHARACTER_Y(idxEnemy);
	ADD_LIGHTNING(charx,chary,enemyx,enemyy,1.2);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_HIDE,GET_TEXT("[SPELL_SCBO_NAME]"));
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local avgMana = (GET_MANA_AIR(idxCaster) + 
				GET_MANA_EARTH(idxCaster) +
				GET_MANA_FIRE(idxCaster) +
				GET_MANA_WATER(idxCaster))/4;

	if (avgMana < 8) then
		return 0;
	end
	return Std_AISpellcastingChance(avgMana*2);
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
SCBO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};









