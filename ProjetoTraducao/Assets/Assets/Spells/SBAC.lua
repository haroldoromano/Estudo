--
--	BATTLECRY
--		Creates a +5 Skull.  If RED 15+, then no end turn	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Find a grid without a skull on it (and no skulls adjacent!)
	local x,y = GetRandomGrid_Isolated2(GEM_SKULL,GEM_REDSKULL);
	
	-- Change it
	SET_GEM(x,y,GEM_REDSKULL);				
	Std_GridSpellEffect(x,y,SPELLFX_WAR,1);

	-- Extra turn?
	if (GET_MANA_FIRE(idxCaster) >= 15) then
		EXTRA_TURN(1,0);
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_DEFAULTGFXONLY,GET_TEXT("[SPELL_SBAC_NAME]"));
		
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
SBAC = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








