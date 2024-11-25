--
--	BURIAL
--		Turns all Skulls and Gold Coins into Green Gems	
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
			local gemType = GET_GEM(x,y);
			if (gemType  == GEM_SKULL or 
			    gemType  == GEM_REDSKULL or
			    gemType == GEM_GOLD) then
				SET_GEM(x,y,GEM_GREEN);				
				ADD_EFFECT_TO_GRID(x,y,"GreenSparkle");
			end
		end
	end
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NECRO,GET_TEXT("[SPELL_SBRL_NAME]"));
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local bonus = CountGems(GEM_SKULL) +
			   CountGems(GEM_GOLD);


	return Std_AISpellcastingChance(bonus*5);
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
SBRL = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};













