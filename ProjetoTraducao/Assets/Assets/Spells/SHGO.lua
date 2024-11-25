--
--	HURL GOBLIN
--		Explodes a random gem - effect  x12	
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
	local amt = 20;
	local x,y = GetRandomGrid();
	Std_GridSpellEffect(x,y,SPELLFX_FIREBALL,1);
	PLAY_SOUND("snd_redskull");
	
	-- Data
	SetMultiplierEffects(false);
	local myGem = GET_GEM(x,y);
	DESTROY_GEM(x,y);
	if (myGem == GEM_AIR) then
		ADD_MANA_AIR(idxCaster,amt);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_YELLOW);
	elseif (myGem == GEM_EARTH) then
		ADD_MANA_EARTH(idxCaster,amt);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_GREEN);
	elseif (myGem == GEM_FIRE) then
		ADD_MANA_FIRE(idxCaster,amt);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_RED);
	elseif (myGem == GEM_WATER) then
		ADD_MANA_WATER(idxCaster,amt);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MANA]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_CYAN);
	elseif (myGem == GEM_GOLD) then
		ADD_GOLD(idxCaster,amt);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_GOLD]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_ORANGE);
	elseif (myGem == GEM_STAR) then
		ADD_XP(idxCaster,amt);
		local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_XP]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxCaster, msg,2,MESSAGE_PURPLE);
	elseif (myGem == GEM_SKULL) then
		Std_InflictDamage(amt,idxCaster);
	elseif (myGem == GEM_REDSKULL) then
		Std_InflictDamage(amt*5,idxCaster);
	end
	SetMultiplierEffects(true);
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_DEFAULTGFXONLY,GET_TEXT("[SPELL_SHGO_NAME]"));
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	return Std_AISpellcastingChance(30);
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
SHGO = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};













