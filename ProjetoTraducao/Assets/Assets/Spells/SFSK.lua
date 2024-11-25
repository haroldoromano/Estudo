--
--	FLAMING SKULLS
--		Green->Skulls Blue->Red
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Special FX
	EffectOnAllGems(GEM_GREEN,"WhiteSparkle");
	EffectOnAllGems(GEM_BLUE,"RedSparkle");

	-- Now change them
	ChangeAllGems(GEM_GREEN,GEM_SKULL);
	ChangeAllGems(GEM_BLUE,GEM_RED);

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NECRO,GET_TEXT("[SPELL_SFSK_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local num = CountGems(GEM_GREEN) + CountGems(GEM_BLUE);
	if (num < 15) then
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
SFSK = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};







