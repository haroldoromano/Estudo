--
--	EVAPORATE
--		Turn blue gems to yellow gems	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Number of Gems
	local amt = 5 + GET_MANA_AIR(idxCaster)/8;
	
	-- Start Converting them
	local done = false;
	local tries = 0;
	repeat
		local x,y = GetRandomGrid_Not(GEM_YELLOW);
		SET_GEM(x,y,GEM_YELLOW);				
		ADD_EFFECT_TO_GRID(x,y,"YellowSparkle");
		amt = amt - 1;
		tries = tries+1;
	until (tries > 1000 or amt <= 0)
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_AIR,GET_TEXT("[SPELL_SGOW_NAME]"));
	
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
SGOW = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





