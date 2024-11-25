--
--	CONFLAGRATION
--		Change all of 1 gem into red	
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
				SET_GEM(x,y,GEM_RED);				
				ADD_EFFECT_TO_GRID(x,y,"RedSparkle");
			end
		end
	end
	

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_FIREBALL,GET_TEXT("[SPELL_SCON_NAME]"));
	Std_GridSpellEffect(2,2,SPELLFX_FIREBALL,0);
	Std_GridSpellEffect(5,3,SPELLFX_FIREBALL,0);
	Std_GridSpellEffect(3,5,SPELLFX_FIREBALL,0);
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numYellow = CountGems(GEM_YELLOW);
	local numGreen = CountGems(GEM_GREEN);
	local numBlue = CountGems(GEM_BLUE);
	local numStar = CountGems(GEM_STAR);
	local numGold = CountGems(GEM_GOLD);

	local x = 1;
	local y = 1;
	local modifier = -100;
	local num = 0;
	
	-- Find the best choice
	if (numYellow > numGreen and numYellow > numBlue and numYellow > numStar and numYellow > numGold) then
		num = numYellow;
		x,y = GetRandomGrid_Type(GEM_YELLOW);
	elseif (numGreen > numYellow and numGreen > numBlue and numGreen > numStar and numGreen > numGold) then
		num = numGreen;
		x,y = GetRandomGrid_Type(GEM_GREEN);
	elseif (numBlue > numYellow and numBlue > numGreen and numBlue > numStar and numBlue > numGold) then
		num = numBlue;
		x,y = GetRandomGrid_Type(GEM_BLUE);
	elseif (numStar > numYellow and numStar > numBlue and numStar > numGreen and numStar > numGold) then
		num = numStar;
		x,y = GetRandomGrid_Type(GEM_STAR);
	elseif (numGold > numYellow and numGold > numBlue and numGold > numGreen and numGold > numStar) then
		num = numGold;
		x,y = GetRandomGrid_Type(GEM_GOLD);
	else
		return 0;
	end
	
	if (num > 11) then
		modifier = num*3;
	end
	
	SET_INPUT_DATA(0,x);
	SET_INPUT_DATA(1,y);
	
	return Std_AISpellcastingChance(modifier);
	
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
SCON = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






