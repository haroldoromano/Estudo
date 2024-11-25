--
--	MANA BURN
--		-5 to all enemy mana totals, Red Mana 8+, no end turn
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
	local amt = 5;
	local idxEnemy = GET_ENEMY(idxCaster,0);
	SUBTRACT_MANA_EARTH(idxEnemy,amt);
	SUBTRACT_MANA_FIRE(idxEnemy,amt);
	SUBTRACT_MANA_AIR(idxEnemy,amt);
	SUBTRACT_MANA_WATER(idxEnemy,amt);

	-- Message
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",amt);		
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,MESSAGE_WHITE);
	
	-- Extra Turn?
	if (GET_MANA_FIRE(idxCaster) >= 8) then
		EXTRA_TURN(1,0);
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_DEFAULTGFXONLY,GET_TEXT("[SPELL_SMBU_NAME]"));
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

   local idxEnemy = GET_ENEMY(idxCaster,0);
   local totalMana = GET_MANA_AIR(idxEnemy) +
			GET_MANA_EARTH(idxEnemy) +
			GET_MANA_FIRE(idxEnemy) +
			GET_MANA_WATER(idxEnemy);
   if (totalMana <= 10) then
	return -50;
   end
   return Std_AISpellcastingChance((totalMana-10)*2);
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
SMBU = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};









