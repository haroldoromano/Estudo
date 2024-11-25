--
--	DEATHBRINGER
--		Randomly creates skulls equal in number to one third red mana	
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
	local amt = GET_MANA_FIRE(idxCaster)/3;
	if (amt > 10) then
		amt = 10;
	end
	
	-- Start Converting them
	local done = false;
	local tries = 0;
	repeat
		local x,y = GetRandomGrid_Not2(GEM_SKULL,GEM_REDSKULL);
		SET_GEM(x,y,GEM_SKULL);				
		ADD_EFFECT_TO_GRID(x,y,"RedSparkle");
		amt = amt - 1;
		tries = tries+1;
	until (tries > 1000 or amt <= 0)
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NECRO,GET_TEXT("[SPELL_SDBR_NAME]"));
	
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
SDBR = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






