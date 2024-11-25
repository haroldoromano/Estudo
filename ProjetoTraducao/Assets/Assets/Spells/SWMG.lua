--
--	WILD MAGIC
--		Creates 4 wildcards (turn doesn't end if all mana 12+)	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Number of Gems
	local amt = 4;
	
	-- Start Converting them
	local tries = 0;
	repeat
		local x,y = GetRandomGrid();
		if (not IsWildcard(GET_GEM(x,y))) then
			amt = amt - 1;
			Std_GridSpellEffect(x,y,SPELLFX_CHAOS,0);
			myGem = GEM_WILDCARDx2 + GET_RANDOM_SYNC(0,6);
			SET_GEM(x,y,myGem);
		end
		tries = tries+1;
	until (tries > 1000 or amt <= 0)
		
	-- Extra Turn?
	if (GET_MANA_EARTH(idxCaster) >= 12 and GET_MANA_AIR(idxCaster) >= 12 and 
		GET_MANA_WATER(idxCaster) >= 12 and GET_MANA_FIRE(idxCaster) >= 12) then
		
			EXTRA_TURN(1,0);
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_CHAOS,GET_TEXT("[SPELL_SWMG_NAME]"));
	
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
SWMG = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





