--
--	CLEAVE
--		Does one damage to enemy for each yellow gem on the grid	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Change it
	local amt_damage = CountGems(GEM_YELLOW);
	DeleteAllGems(GEM_YELLOW,EFFECT_YELLOW_SPARKLE,1);
	
	-- Do damage
	if (amt_damage > 0) then	
		SetMultiplierEffects(false);
		Std_InflictDamage(amt_damage,idxCaster);		
		SetMultiplierEffects(true);
	end
	
	Std_CastSpellEffect(idxCaster,SPELLFX_SPIN,GET_TEXT("[SPELL_SCLV_NAME]"));
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numYellow = CountGems(GEM_YELLOW);
	if (numYellow < 10) then
		return 0;
	end
	
	local modifier = numYellow*2;
	
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
SCLV = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






