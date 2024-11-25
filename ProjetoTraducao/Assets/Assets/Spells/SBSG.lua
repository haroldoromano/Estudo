--
--	BESIEGE
--		Explodes a random group of gems	
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
	local x,y = GetRandomGrid();
	
	SetMultiplierEffects(false);
	ExplodeGem(x,y);
	SetMultiplierEffects(true);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_DEFAULTGFXONLY,GET_TEXT("[SPELL_SBSG_NAME]"));

	-- Special FX on grid
	Std_GridSpellEffect(x,y,SPELLFX_FIREBALL,1);
		
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(15);
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
SBSG = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






