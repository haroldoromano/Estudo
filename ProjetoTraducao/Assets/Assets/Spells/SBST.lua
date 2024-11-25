--
--	BONE STRIKE
--		Reduces enemy green mana to zero
--		Extra turn if mana 10+	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local idxEnemy = GET_ENEMY(idxCaster,0);
		
	-- Extra Turn?
	local amt = GET_MANA_EARTH(idxEnemy);
	if (amt  >= 10) then
		EXTRA_TURN(1,0);
	end

	-- effect
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",amt);
	SET_MANA_EARTH(idxEnemy, 0);
		
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,2);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_DEFAULTGFXONLY,GET_TEXT("[SPELL_SBST_NAME]"));
	
	-- Special FX on enemy
	Std_EnemySpellEffect(idxCaster,SPELLFX_STUN,1);
		
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local idxEnemy = GET_ENEMY(idxCaster,0);
	local bonus = GET_MANA_EARTH(idxEnemy );
	if (bonus > 5) then
		bonus = bonus*3;
	else
		bonus = bonus - 10;
	end
	return Std_AISpellcastingChance(bonus);
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
--		DECLARE TABLE	
--

SBST = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};












