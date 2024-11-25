--
--	STEAL
--		Takes 25 Gold from opponent	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Amount
	local idxEnemy = GET_ENEMY(idxCaster,0);
	local amt_gold = GET_GOLD(idxEnemy);
	if (amt_gold > 25) then
		amt_gold = 25;
	end
	
	-- Effect
	Std_LoseGold(amt_gold, idxEnemy);
	Std_GainGold(amt_gold, idxCaster);
 
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SSTL_NAME]"));
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

	return Std_AISpellcastingChance(-10);
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
SSTL = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



