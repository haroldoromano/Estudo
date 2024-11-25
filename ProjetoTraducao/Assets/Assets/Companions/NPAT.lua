--
--	Patch
--		20% chance of 25 pts damage	
--


------------------------------------------------
--
-- OnStartBattle
--
--    A battle has just started
--    This is called before the first turn
--
local function OnStartBattle(characterIdx)

	local amt = 25;
	local idxEnemy = GET_ENEMY(characterIdx,0);
	local enemyLife = GET_LIFE(idxEnemy);	

	if (IS_MONSTER(idxEnemy) and PERCENTILE_CHANCE_SYNC() < 20
		and enemyLife > amt) then

		SUBTRACT_LIFE(idxEnemy ,amt,characterIdx);
	
		-- Special FX on enemy
		local msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE2]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg_damage,2,6);
		PLAY_SOUND("snd_redskull");

		ACTIVATE_COMPANION("NPAT");
	end
	
	return;
end




--	
--		DECLARE TABLE	
--

NPAT = {
   OnStartBattle = OnStartBattle,
};












