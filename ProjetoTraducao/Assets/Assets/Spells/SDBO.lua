--
--	DARKBOLT
--		Blind for 1 turn + drains 5 Yellow/Red Mana	
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
	local dur = 2;
	Std_InflictStatusEffect(STATUS_EFFECT_BLIND,dur,idxCaster);	
	Std_EnemySpellEffect(idxCaster,SPELLFX_WEB,1);
	
	-- Mana effect
	local amt = 5;
	local idxEnemy = GET_ENEMY(idxCaster,0);
	SUBTRACT_MANA_AIR(idxEnemy,amt);
	SUBTRACT_MANA_FIRE(idxEnemy,amt);

	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",amt);		
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,0);
	ADD_TEXT_MESSAGE_TO_CHARACTER2(idxEnemy,msg,2,1);

		
	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SDBO_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(15);
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

SDBO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};












