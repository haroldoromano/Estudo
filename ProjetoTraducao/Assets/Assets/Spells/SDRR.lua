--
--	NEW SPELL
--		Spell Description	
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
	EffectOnAllGems(GEM_RED,"RedSparkle");
	EffectOnAllGems(GEM_YELLOW,"YellowSparkle");

	-- Now change them
	ChangeAllGems(GEM_RED,GEM_SKULL);
	ChangeAllGems(GEM_YELLOW,GEM_SKULL);

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SDRR_NAME]"));
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local bonus = CountGems(GEM_RED)+CountGems(GEM_YELLOW);
	if (bonus <= 6) then
		bonus = -20;
	else
		bonus = bonus*5;
	end
	return Std_AISpellcastingChance(bonus);
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
--		DECLARE TABLE	
--

SDRR = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};









