--
--	REINCARNATION
--		All non-gems are changed into gems of random colors	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Loop through each grid
	SetMultiplierEffects(false);
	local x,y,gt,typ,chance;
	for y = 1,8 do
		for x = 1,8 do
			gt = GET_GEM(x,y);
			if (gt == GEM_GOLD or gt == GEM_STAR or gt == GEM_SKULL or gt == GEM_REDSKULL) then
				
				chance = PERCENTILE_CHANCE_SYNC();
				if (chance <= 25) then
					typ = GEM_GREEN;
				elseif (chance <= 50) then
					typ = GEM_RED;
				elseif (chance <= 75) then
					typ = GEM_BLUE;
				else
					typ = GEM_YELLOW
				end
				SET_GEM(x,y,typ);
			end
		end
	end
	SetMultiplierEffects(true);
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SRNC_NAME]"));
	
	
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
SRNC = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






