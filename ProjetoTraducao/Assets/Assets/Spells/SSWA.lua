--
--	SWALLOW WHOLE
--		Does damage to an opponent equal to their OWN green mana	
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
	local amt_damage = 4 + GET_MANA_EARTH(idxEnemy);
	Std_InflictDamage(amt_damage, idxCaster);
	Std_EnemySpellEffect(idxCaster,SPELLFX_FEAR,1);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SSWA_NAME]"));
	
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
	local mana_green = GET_MANA_EARTH(idxEnemy);
	if (mana_green < 7) then
		return 0;
	end
	
	return Std_AISpellcastingChance(mana_green);
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
SSWA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};


