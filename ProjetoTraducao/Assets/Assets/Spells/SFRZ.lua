--
--	FREEZE
--		Turn red gems to blue gems... add +1 blue mana for each red gem changed
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local numRed = CountGems(GEM_RED);
	ADD_MANA_WATER(idxCaster,numRed);
	EffectOnAllGems(GEM_RED,"CyanSparkle");
	ChangeAllGems(GEM_RED,GEM_BLUE);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_FROST,GET_TEXT("[SPELL_SFRZ_NAME]"));
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numRed = CountGems(GEM_RED);
	if (numRed <= 4) then
		return 0;
	end
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
SFRZ = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






