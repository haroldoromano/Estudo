--
--	BURN
--		Turn green & blue gems to yellow gems	
--		Yellow mana 15+ => no end of turn
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
			if (GET_GEM(x,y) == GEM_EARTH) then
				SET_GEM(x,y,GEM_AIR);				
				ADD_EFFECT_TO_GRID(x,y,"GreenSparkle");
			end
			if (GET_GEM(x,y) == GEM_WATER) then
				SET_GEM(x,y,GEM_AIR);				
				ADD_EFFECT_TO_GRID(x,y,"CyanSparkle");
			end
		end
	end
		
	-- End of turn?
	if (GET_MANA_AIR(idxCaster) >= 15) then
		EXTRA_TURN(1,0);
	end

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_AIR,GET_TEXT("[SPELL_SSOA_NAME]"));
	
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
	
	local numGems = 0;
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == GEM_EARTH) then
				numGems = numGems+1;
			end
			if (GET_GEM(x,y) == GEM_WATER) then
				numGems = numGems+1;
			end
		end
	end
	chance = chance + numGems;
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	-- specific things to look for
	if (numGems < 8) then
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
SSOA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





