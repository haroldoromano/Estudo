--
--	TRAMPLE
--		Deal damage equal to earth mana / 2	
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
	local idxEnemy = GET_ENEMY(idxCaster,0);
	local damage = GET_MANA_EARTH(idxCaster)/2;
	if (damage < 1) then
		damage = 1;
	end
	
	-- Set up message
	local msg;
	if (damage < 2) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE1]",damage);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE2]",damage);
	end
	local doneMsg = false;
	
	-- Actual effect
	--SUBTRACT_LIFE(idxEnemy,damage,idxCaster);
	Std_InflictDamage(damage,idxCaster);	
	
	-- Special FX on caster/enemy
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_STRM_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_STONE,0);
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local mana_earth = GET_MANA_EARTH(idxCaster);
	if (mana_earth < 10) then
		return 0;
	end
	
	local modifier = -40 + mana_earth*2;
	
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
STRM = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






