--
--	HEADBUTT
--		Destroys red gems
--		Enemy misses 1 turn +1 per 8 gems destroyed	
--


------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)


	local numGems = CountGems(GEM_RED);
	local numTurns = 2 + (numGems/8);
	
	-- Detsroy Gems
	DeleteAllGems(GEM_RED,"RedSparkle");

	-- Set up message
	local displayedTurns = numTurns-1;
	local msg_turn;
	if (displayedTurns < 2) then
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",displayedTurns);
	else
	   msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN2]",displayedTurns);
	end
	
	-- Miss turns
	local idxEnemy = GET_ENEMY(idxCaster,0);
	MISS_TURNS(idxEnemy,numTurns);
	ADD_TEXT_MESSAGE2(msg_turn,2,6);
	doneMsg = true;
		
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_WAR,GET_TEXT("[SPELL_SHBT_NAME]"));
	Std_EnemySpellEffect(idxCaster,SPELLFX_STUN,1);
	
end

------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local numGems = CountGems(GEM_RED);
	local bonus = 5;
	if (numGems >= 8) then
		bonus = numGems*3;
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

SHBT = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};










