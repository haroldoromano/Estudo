--
--	HOWL
--		4 green mana + Inflict Fear	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- Damage
	ADD_MANA_EARTH(idxCaster, 4);	
	
	-- Fear
	local dur = 5 + GET_MANA_AIR(idxCaster)/5;
	Std_InflictStatusEffect(STATUS_EFFECT_FEAR,dur,idxCaster);	
	Std_EnemySpellEffect(idxCaster,SPELLFX_FEAR,0);
	

	-- Special Effect
	PLAY_SOUND("snd_howl");
	Std_CastSpellEffect(idxCaster,SPELLFX_AIR,GET_TEXT("[SPELL_SHWL_NAME]"));
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local evaluation = EVALUATE_BOARD();
	local chance = PERCENTILE_CHANCE_SYNC();
	
	local idxEnemy = GET_ENEMY(idxCaster,0);
	if (HAS_STATUS_EFFECT(idxEnemy,STATUS_EFFECT_FEAR)) then
		chance = chance - 40;
	end
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	return 1;
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
SHWL = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};



