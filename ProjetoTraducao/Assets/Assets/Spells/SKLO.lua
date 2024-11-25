--
--	KNIGHT LORD
--		Doubles stars in play	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local typ = GET_GEM(gridx,gridy);

	-- Loop through each column
	local numStars = CountGems(GEM_STAR);
	local i,x,y;
	for i = 1,numStars do
		x,y = GetRandomGrid_Not(GEM_STAR);
		SET_GEM(x,y,GEM_STAR);				
		ADD_EFFECT_TO_GRID(x,y,"PurpleSparkle");
	end
	
	
	
	-- Special FX on caster
	PLAY_SOUND("snd_xp");
	Std_CastSpellEffect(idxCaster,SPELLFX_GOOD,GET_TEXT("[SPELL_SKLO_NAME]"));
	
	
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
SKLO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






