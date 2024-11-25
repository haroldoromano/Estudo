--
--	STONE GAZE
--		Turn green gems to skulls	(15+ Green Mana = No end turn)
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
	EffectOnAllGems(GEM_GREEN,"GreenSparkle");
	ChangeAllGems(GEM_GREEN, GEM_SKULL);

	if (GET_MANA_EARTH(idxCaster) >= 15) then
		EXTRA_TURN(1,0);
	end
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_STONE,GET_TEXT("[SPELL_SSGZ_NAME]"));
	
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
	
	local numGreenGems = CountGems(GEM_GREEN);
	chance = chance + numGreenGems;
	
	-- Red Mana
	if (GET_MANA_EARTH(idxCaster) >= 15) then
		chance = chance - 30;
	else
		chance = chance + 30;
	end
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	-- specific things to look for
	if (numGreenGems < 6) then
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
SSGZ = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




