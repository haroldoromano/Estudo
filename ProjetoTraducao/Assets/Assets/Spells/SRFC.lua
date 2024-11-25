--
--	REINFORCEMENTS
--		Destroys Gold
--		Each one gives me a point of healing	
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
	local amt_heal = 0;
	local x;
	local y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == GEM_GOLD) then
				DELETE_GEM(x,y);
				ADD_EFFECT_TO_GRID(x,y,"YellowSparkle");
				amt_heal = amt_heal + 1;
			end
		end
	end
	
	-- Healing
	ADD_LIFE(idxCaster,amt_heal);
	
	local msg;
	if (amt_heal == 1) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING1]",amt_heal);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING2]",amt_heal);
	end
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,6);
	
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_GOOD,GET_TEXT("[SPELL_SRFC_NAME]"));
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
			if (GET_GEM(x,y) == GEM_GOLD) then
				numGems = numGems +1;
			end
		end
	end
	chance = chance + numGems ;
	
	-- Enough skulls to bother?
	if (numGems <= 4) then
		return 0;
	end
	
	-- Damaged?
	if (GET_LIFE(idxCaster) >= GET_MAX_LIFE(idxCaster) - 8) then
		return 0;
	end
	if (GET_LIFE(idxCaster) < GET_MAX_LIFE(idxCaster)/2) then
		chance = chance + 25;
	end
	if (GET_LIFE(idxCaster) < GET_MAX_LIFE(idxCaster)/4) then
		chance = chance + 25;
	end
	
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
SRFC = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








