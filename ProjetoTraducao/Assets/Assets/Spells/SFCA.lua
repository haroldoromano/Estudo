--
--	FLAME CANNON
--		Explode 4 random gems	
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

	--Effect
	local count;
	local xpix, ypix, oldxpix, oldypix, firstxpix, firstypix;
	SetMultiplierEffects(false);
	for count=1,4 do
		local x,y;
		repeat
			x,y = GetRandomGrid();
		until (GET_GEM(x,y) ~= GEM_EMPTY);

		ExplodeGem(x,y);
		-- Lightning
		xpix = GET_GRID_X(x);
		ypix = GET_GRID_Y(y);
		if (count > 1) then
			ADD_LIGHTNING(oldxpix,oldypix, xpix,ypix, 1.2);	
		else
			firstxpix = xpix;
			firstypix = ypix;
		end
		oldxpix = xpix;
		oldypix = ypix;
	end
	ADD_LIGHTNING(oldxpix,oldypix, firstxpix, firstypix, 1.2);	

	SetMultiplierEffects(true);
	PLAY_SOUND("snd_redskull");
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_FIREBALL,GET_TEXT("[SPELL_SFCA_NAME]"));
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(20);
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
SFCA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};











