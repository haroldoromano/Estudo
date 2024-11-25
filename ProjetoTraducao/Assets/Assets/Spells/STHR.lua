--
--	THRUST
--		Destroy a single gem	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Charge the mana first
	HANDLE_SPELL_COST(idxCaster);

	local gridx = GET_INPUT_DATA(0);
	local gridy = GET_INPUT_DATA(1);

	-- Destroy it
	SetMultiplierEffects(false);
	DESTROY_GEM(gridx,gridy);
	SetMultiplierEffects(true);

	Std_GridSpellEffect(gridx,gridy,SPELLFX_WAR,1);
		
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_STHR_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	-- Only do this if I see red skulls
	local numRedSkulls = CountGems(GEM_REDSKULL);
	if (numRedSkulls <= 0) then
		return 0;
	end
	
	-- Store a grid in case we cast!
	local x,y = GetRandomGrid_Type(GEM_REDSKULL);
	SET_INPUT_DATA(0,x);
	SET_INPUT_DATA(1,y);

	return Std_AISpellcastingChance(numRedSkulls*10);
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
STHR = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};





