--
--	F.O.D.
--		Put down a +5 Skull	
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

	-- Destroy it
	SET_GEM(gridx,gridy,GEM_REDSKULL);
	Std_GridSpellEffect(gridx,gridy,SPELLFX_NECRO,1);
	
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SFOD_NAME]"));
	
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
SFOD = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



