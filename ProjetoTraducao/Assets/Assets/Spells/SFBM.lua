--
--	FIREBOMB
--		Attaches a firebomb for 12 turns	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)
		
	local dur = 12;
	Std_InflictStatusEffect("EFBO",dur,idxCaster);	

	-- Special Effect
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SFBM_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_FIREBALL,0);

end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(10);
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

SFBM = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};









