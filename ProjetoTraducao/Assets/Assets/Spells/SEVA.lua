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

	-- Loop through each column
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == 4) then
				SET_GEM(x,y,3);				
				ADD_EFFECT_TO_GRID(x,y,"YellowSparkle");
			end
		end
	end
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WATER,GET_TEXT("[SPELL_SEVA_NAME]"));
	
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
SEVA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






