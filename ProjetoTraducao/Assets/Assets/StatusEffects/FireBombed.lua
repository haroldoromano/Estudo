--
--	FIRE BOMB
--		5 Damage if Red Mana is 12+
--

local function OnStartTurn(characterIdx,turnNumber)

	if (GET_MANA_FIRE(characterIdx) >= 12) then
	    
	    local idxEnemy = GET_ENEMY(characterIdx,0);
	    Std_InflictDamage(5,idxEnemy);
		
		-- Special FX on caster
		if (PERCENTILE_CHANCE_SYNC() < 50) then
			ADD_ANIMEFFECT_TO_CHARACTER(characterIdx ,"SpellFireball0");
		else
			ADD_ANIMEFFECT_TO_CHARACTER(characterIdx ,"SpellFireball1");
		end
	
	end
	
	return;
end

--	
--		DECLARE TABLE	
--

FireBombed = {
	OnStartTurn = OnStartTurn,
};

