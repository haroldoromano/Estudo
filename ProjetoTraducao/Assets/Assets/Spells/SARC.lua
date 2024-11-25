--
--	ARCHERY
--		Does damage to an opponent equal to their OWN yellow mana	
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
	local amt_damage = GET_MANA_AIR(idxEnemy)/2;
	Std_InflictDamage(amt_damage, idxCaster);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_AIR,GET_TEXT("[SPELL_SARC_NAME]"));
	
	-- Another Turn
	if (GET_MANA_AIR(idxCaster) >= 15) then
		EXTRA_TURN(1,0);
	end
	
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
	local mana_yellow = GET_MANA_AIR(idxEnemy);
	if (mana_yellow < 9) then
		return 0;
	end
	
	return Std_AISpellcastingChance(mana_yellow);
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
SARC = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};







