--
--	FIREBALL
--		8 damage + destroy gems around a grid
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

	-- Damage effect
	local damage = 8;
	Std_InflictDamage(damage, idxCaster);
	
	-- Get the chosen grid
	local gridx = GET_INPUT_DATA(0);
	local gridy = GET_INPUT_DATA(1);
	
	-- Destruction effect
	local x,y;
	SetMultiplierEffects(false);
	for y = gridy-1,gridy+1 do
		for x = gridx-1,gridx+1 do
			if (x >= 1 and x <= 8 and y >= 1 and y <= 8) then
				DESTROY_GEM(x,y);
			end
		end
	end
	SetMultiplierEffects(true);
	
	-- Special FX on caster
	ADD_ANIMEFFECT_TO_GRID(gridx,gridy,SPELLFX_FIREBALL,1);
	Std_CastSpellEffect(idxCaster,SPELLFX_SPARKLE,GET_TEXT("[SPELL_SFBA_NAME]"));
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local modifier = 0;
	local x,y = GetRandomGrid_Type(GEM_REDSKULL);
	if (GET_GEM(x,y) ~= GEM_REDSKULL) then
		local x,y = GetRandomGrid_Type(GEM_SKULL);
		if (GET_GEM(x,y) ~= GEM_SKULL) then
			return 0;
		end
	else
		modifier = 20;
	end
	
	SET_INPUT_DATA(0,x);
	SET_INPUT_DATA(1,y);
	
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
SFBA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};








