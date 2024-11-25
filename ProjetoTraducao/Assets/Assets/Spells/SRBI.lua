--
--	RABID BITE
--		4 damage + Inflict Disease	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Damage
	Std_InflictDamage(4,idxCaster);	
	
	-- Disease
	local dur = 5 + GET_MANA_WATER(idxCaster)/5;
	Std_InflictStatusEffect("EDIS",dur,idxCaster);	
	Std_EnemySpellEffect(idxCaster,SPELLFX_DISEASE,1);
	
	-- Special Effect
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SRBI_NAME]"));
	
	
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
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	return 1;
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
SRBI = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



