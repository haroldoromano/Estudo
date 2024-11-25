--
--	DEATH GAZE
--		Halves enemy hit points + a random skull for each 5 full points done	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	--Effect
	local idxEnemy = GET_ENEMY(idxCaster,0);
	local amt_damage = GET_LIFE(idxEnemy)/2;
	Std_InflictDamage(amt_damage, idxCaster);
	
	-- Add some skulls (max 10)
	local numSkulls = amt_damage/5;
	if (numSkulls > 10) then
		numSkulls = 10;
	end
	if (numSkulls > 0) then
		local i,x,y;
		for i = 1,numSkulls do
			x,y = GetRandomGrid_Not2(GEM_SKULL,GEM_REDSKULL);
			SET_GEM(x,y,GEM_SKULL);				
			ADD_EFFECT_TO_GRID(x,y,"GreenSparkle");
		end
		PLAY_SOUND("snd_stone");
	end
	
	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,0,GET_TEXT("[SPELL_SDGZ_NAME]"));

	-- Special FX on enemy
	Std_EnemySpellEffect(idxCaster,SPELLFX_NECRO,1);
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local idxEnemy = GET_ENEMY(idxCaster,0);
	local modifier = GET_LIFE(idxEnemy)-20;
	
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
SDGZ = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};







