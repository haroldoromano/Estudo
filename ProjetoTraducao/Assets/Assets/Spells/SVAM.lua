--
--	VAMPIRISM
--		Drain 5 life and gives it to caster	
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
	local amt_damage = 5 + GET_MANA_FIRE(idxCaster)/10;
	local idxEnemy = GET_ENEMY(idxCaster,0);
	if (amt_damage > GET_LIFE(idxEnemy)) then
		amt_damage = GET_LIFE(idxEnemy);
	end
	local amt_heal = amt_damage;
	
	-- Damage
	Std_InflictDamage(amt_damage, idxCaster);
	Std_EnemySpellEffect(idxCaster,SPELLFX_CHAOS,1);	
	
	-- Healing
	Std_Healing(amt_heal, idxCaster);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_HEALING,GET_TEXT("[SPELL_SVAM_NAME]"));	
	
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
	
	if (GET_MAX_LIFE(idxCaster) - GET_LIFE(idxCaster) < 8) then
		return 0;
	end
	
	-- bias
	chance  = chance - GET_MANA_FIRE(idxCaster);
	evaluation = evaluation - GET_MANA_FIRE(idxCaster)/6;
	
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
SVAM = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




