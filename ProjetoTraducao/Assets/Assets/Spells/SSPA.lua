--
--	SPIN ATTACK
--		Destroys all gems centered around a chosen gem	
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

	-- Get the chosen grid
	local gridx = GET_INPUT_DATA(0);
	local gridy = GET_INPUT_DATA(1);
	
	-- Change it
	local x,y;
	SetMultiplierEffects(false);
	for y = gridy-1,gridy+1 do
		for x = gridx-1,gridx+1 do
			if (x >= 1 and x <= 8 and y >= 1 and y <= 8) then
				if (x ~= gridx or y ~= gridy) then
					DESTROY_GEM(x,y);
				end
			end
		end
	end
	SetMultiplierEffects(true);
	Std_GridSpellEffect(x,y,SPELLFX_SPIN,1);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SSPA_NAME]"));

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
SSPA = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};









