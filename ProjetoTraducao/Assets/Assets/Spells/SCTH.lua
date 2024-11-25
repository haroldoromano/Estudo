--
--	CALL THE HORDE
--		Deletes all Green + Red and adds their 
--		total number to green mana & red mana & life
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- No bonuses from this!
	SetMultiplierEffects(false);
	
	-- Gem effect
	local numGems = CountGems(GEM_RED) +  CountGems(GEM_GREEN);
	DeleteAllGems(GEM_GREEN,"GreenSparkle");
	DeleteAllGems(GEM_RED,"RedSparkle");
	ADD_MANA_EARTH(idxCaster, numGems );
	ADD_MANA_FIRE(idxCaster, numGems );
	ADD_LIFE(idxCaster, numGems );
	
	-- Allow bonuses again
	SetMultiplierEffects(true);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_HEALING,GET_TEXT("[SPELL_SCTH_NAME]"));
	Std_CasterSpellEffect(idxCaster,SPELLFX_SPARKLE,1);
	
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell\n"
--    Returns 1 if it should, 0 if it should not\n"
--
local function ShouldAICastSpell(idxCaster)

	local numGems = CountGems(GEM_RED) +  CountGems(GEM_GREEN);
	local bonus = numGems*5;
	if (numGems < 8) then
		bonus = -20;
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

SCTH = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};














