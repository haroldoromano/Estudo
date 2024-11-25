--
--	WAKETHEDEAD
--		Turn 1 skull -> RedSkull for each 5 Green mana	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- How many to convert?
	local numSkulls = GET_MANA_EARTH(idxCaster)/5;
	
	-- Do them all
	local i,x,y;
	for i=1,numSkulls do
		x,y = GetRandomGrid_Type(GEM_SKULL);
		if (GET_GEM(x,y) == GEM_SKULL) then
			SET_GEM(x,y,GEM_REDSKULL);
			Std_GridSpellEffect(x,y,SPELLFX_NECRO,0);
			--ADD_EFFECT_TO_GRID(x,y,"WhiteSparkle");
		end
	end
	--PLAY_SOUND("snd_stone");
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_NECRO,GET_TEXT("[SPELL_SWTD_NAME]"));
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	-- We need some skulls
	local numSkulls = CountGems(GEM_SKULL);
	if (numSkulls < 3) then
		return 0;
	end

	-- Modify it if we have lots of green mana
	local modifier = 0;
	if (GET_MANA_EARTH(idxCaster) >= 15) then
		modifier = 10;
	end
	if (GET_MANA_EARTH(idxCaster) >= 20) then
		modifier = 30;
	end
	
	return Std_AISpellcastingChance(modifier);
	
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
SWTD = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






