--
--	FROSTBITE
--		Does one damage to enemy for each blue gem on the grid	
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
	local amt_damage = CountGems(GEM_BLUE);
	DeleteAllGems(GEM_BLUE,"CyanSparkle");
	
	-- Do damage
	if (amt_damage > 0) then	
		SetMultiplierEffects(false);
		Std_InflictDamage(amt_damage,idxCaster);		
		SetMultiplierEffects(true);

		Std_EnemySpellEffect(idxCaster,SPELLFX_FROST,1);
	end
	
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SFBT_NAME]"));
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numGems = CountGems(GEM_BLUE);
	if (numGems < 10) then
		return 0;
	end
	
	local modifier = numGems*2;
	
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
SFBT = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};




