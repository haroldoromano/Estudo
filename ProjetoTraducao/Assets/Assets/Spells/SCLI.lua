--
--	CALL LIGHTNING
--		Damage opponent	
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

	-- Which Column?
	local x = GET_INPUT_DATA(0);
	
	-- No bonuses from this!
	SET_EXTRATURN_CHANCE_ENABLED(0);
	SET_WILDCARD_CHANCE_ENABLED(0);
	SET_DAMAGE_MULTIPLIER_ENABLED(0);
	
	-- Loop through each row
	local y;
	for y = 1,8 do
	
		DESTROY_GEM(x,y);
		
	end
	
	-- Allow bonuses again
	SET_EXTRATURN_CHANCE_ENABLED(1);
	SET_WILDCARD_CHANCE_ENABLED(1);
	SET_DAMAGE_MULTIPLIER_ENABLED(1);
	
	-- Lightning
	local xpix  = GET_GRID_X(x);
	local y1pix = GET_GRID_Y(1);
	local y2pix = GET_GRID_Y(8);
	ADD_LIGHTNING(xpix,y1pix, xpix,y2pix, 1.2);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SCLI_NAME]"));
	
	
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
SCLI = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};










