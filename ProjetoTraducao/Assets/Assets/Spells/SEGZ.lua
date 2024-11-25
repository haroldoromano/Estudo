--
--	ENERGIZE
--		+25 Life 
--		Drains all mana
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Add Life
	Std_Healing(25, idxCaster);
	
	-- Drain Mana
	SET_MANA_AIR(idxCaster, 0);
	SET_MANA_WATER(idxCaster, 0);
	SET_MANA_FIRE(idxCaster, 0);
	SET_MANA_EARTH(idxCaster, 0);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_HEALING,GET_TEXT("[SPELL_SEGZ_NAME]"));

end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local bonus = 0;
	local diff = GET_MAX_LIFE(idxCaster) - GET_LIFE(idxCaster);
	if (diff < 10) then
		bonus = -20;
	end
	if (diff > 30) then
		bonus = 50;
	end
	return Std_AISpellcastingChance(bonus);
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
--		DECLARE TABLE	
--

SEGZ = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};













