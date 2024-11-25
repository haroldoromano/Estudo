--
--	BERSERKRAGE
--		Turn red gems to skulls	(15+ Red Mana = No end turn)
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
			if (GET_GEM(x,y) == GEM_RED) then
				SET_GEM(x,y,GEM_SKULL);				
				ADD_EFFECT_TO_GRID(x,y,"RedSparkle");
			end
		end
	end

	if (GET_MANA_FIRE(idxCaster) >= 15) then
		EXTRA_TURN(1,0);
	end
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SBRA_NAME]"));
	
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
	
	local numRedGems = 0;
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == 2) then
				numRedGems = numRedGems+1;
			end
		end
	end
	chance = chance + numRedGems;
	
	-- Red Mana
	if (GET_MANA_FIRE(idxCaster) >= 15) then
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
	if (numRedGems < 6) then
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
SBRA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






