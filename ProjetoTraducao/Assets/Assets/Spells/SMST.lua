--
--	METEOR STORM
--		8 Random Red Gems + full effect for those replaced	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Charge the mana first
	HANDLE_SPELL_COST(idxCaster);

	-- Number of Gems
	local amt = 8;
	
	-- No bonuses from this!
	SET_EXTRATURN_CHANCE_ENABLED(0);
	SET_WILDCARD_CHANCE_ENABLED(0);
	SET_DAMAGE_MULTIPLIER_ENABLED(0);

	-- Start Converting them
	local done = false;
	local tries = 0;
	repeat
		local x,y = GetRandomGrid_Not(GEM_RED);
		ADD_EFFECT_TO_GRID(x,y,"RedSparkle");
		DESTROY_GEM(x,y);
		SET_GEM(x,y,GEM_RED);				
		amt = amt - 1;
		tries = tries+1;
	until (tries > 1000 or amt <= 0)
		
	-- No bonuses from this!
	SET_EXTRATURN_CHANCE_ENABLED(1);
	SET_WILDCARD_CHANCE_ENABLED(1);
	SET_DAMAGE_MULTIPLIER_ENABLED(1);

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_STONE,GET_TEXT("[SPELL_SMST_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(20);
	
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
SMST = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








