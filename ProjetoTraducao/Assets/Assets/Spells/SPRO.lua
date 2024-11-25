--
--	PROMOTION
--		Change all of 1 gem into another	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local gridx = GET_INPUT_DATA(0);
	local gridy = GET_INPUT_DATA(1);
	local typ = GET_GEM(gridx,gridy);

	-- Loop through each column
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == typ) then
				SET_GEM(x,y,6);				
				ADD_EFFECT_TO_GRID(x,y,"PurpleSparkle");
			end
		end
	end
	
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SPRO_NAME]"));
	
	
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
SPRO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};







