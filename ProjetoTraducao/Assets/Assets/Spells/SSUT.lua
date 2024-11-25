--
--	SUMMOPN TEMPEST
--		Destroys 2 random columns of gems	
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

	-- Which Columns?
	local x1 = GET_RANDOM_SYNC(1,8);
	local x2 = x1
	repeat 
		x2 = GET_RANDOM_SYNC(1,8);
	until (x2 ~= x1)
	
	-- No bonuses from this!
	SetMultiplierEffects(false);
	
	-- Loop through each row
	local y;
	for y = 1,8 do
		DESTROY_GEM(x1,y);
		DESTROY_GEM(x2,y);	
	end
	
	-- Allow bonuses again
	SetMultiplierEffects(true);
	
	-- Lightning
	local x1pix  = GET_GRID_X(x1);
	local x2pix  = GET_GRID_X(x2);
	local y1pix = GET_GRID_Y(1);
	local y2pix = GET_GRID_Y(8);
	ADD_LIGHTNING(x1pix,y1pix, x1pix,y2pix, 1.2);
	ADD_LIGHTNING(x2pix,y1pix, x2pix,y2pix, 1.2);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SSUT_NAME]"));
	
	
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
SSUT = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



