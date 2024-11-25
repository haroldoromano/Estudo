--
--	NEW SPELL
--		Spell Description	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

		
	-- Clear Grid
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == GEM_GREEN) then
				local gemType = GEM_WILDCARDx2 + GET_RANDOM_SYNC(0,6);
				SET_GEM(x,y, gemType);				
				ADD_EFFECT_TO_GRID(x,y,"GreenSparkle",1);
			end
		end
	end
	

	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NATURE,GET_TEXT("[SPELL_SNWR_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local numGreen = CountGems(GEM_GREEN);
	if (numGreen < 5) then
		return 0;
	end
	return Std_AISpellcastingChance(numGreen*4);
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

SNWR = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};













