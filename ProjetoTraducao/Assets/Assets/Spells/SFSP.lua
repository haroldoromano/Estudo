--
--	FIRE SIPHON
--		Drains an enemy's Red Mana. Heals that many points on the caster.
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
	local red_mana = GET_MANA_FIRE(idxEnemy );
	SET_MANA_FIRE(idxEnemy , 0);
	Std_Healing(red_mana, idxCaster);
 	
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANALOSS]",red_mana);		
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg,2,0);

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_HEALING,GET_TEXT("[SPELL_SFSP_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_HIDE,0);
	
	
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
	local red_mana = GET_MANA_FIRE(idxEnemy );
	local my_damage = GET_MAX_LIFE(idxCaster) - GET_LIFE(idxCaster);

	if (my_damage < 20 or red_mana < 8) then
		return 0;
	end

	return Std_AISpellcastingChance(my_damage + 5*red_mana - 30);
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

SFSP = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};











