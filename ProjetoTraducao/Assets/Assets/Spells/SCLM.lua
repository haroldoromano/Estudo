--
--	CALM
--		Removes all status effects on all characters
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Remove on me
	CLEAR_STATUS_EFFECTS(idxCaster);

	-- Remove on all others
	local numEnemies = GET_NUM_ENEMIES(idxCaster);
	local enemyCounter;
	for enemyCounter = 1,numEnemies do
		-- Actual effect
		local idxEnemy = GET_ENEMY(idxCaster,enemyCounter-1);
		CLEAR_STATUS_EFFECTS(idxEnemy);
		ADD_EFFECT_TO_CHARACTER(idxEnemy,"GreenSparkle");
	end
	
	-- End of turn?
	if (GET_MANA_WATER(idxCaster) >= 10) then
		EXTRA_TURN(1,0);
	end

		-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,GET_TEXT("[SPELL_SCLM_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

   return Std_AISpellcastingChance(0);
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
SCLM = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



