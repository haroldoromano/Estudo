--
--	WALL OF FIRE
--		Damage comes off of red mana instead of life
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	-- The ideal case
	local red_mana = GET_MANA_FIRE(targetIdx);
	local mana_damage = damage;
	damage = 0;
	
	-- If we are nearing the end
	if (red_mana - mana_damage <= 0) then
		damage = mana_damage - red_mana;
		mana_damage = red_mana;
		
		-- cancel the effect
		local idx = GET_STATUS_EFFECT_INDEX(targetIdx,STATUS_EFFECT_WALLOFFIRE);
		SET_STATUS_EFFECT_DURATION(targetIdx,idx,1);
	end
	
	-- Actual effects
	if (mana_damage > 0) then
		SUBTRACT_MANA_FIRE(targetIdx,mana_damage);
		ADD_EFFECT_TO_CHARACTER(targetIdx,"RedSparkle");
	end
	
	
	return damage;
end


local function OnStartTurn(characterIdx,turnNumber)

	SUBTRACT_MANA_FIRE(characterIdx,2);
	
	-- If we are nearing the end
	if (GET_MANA_FIRE(characterIdx) <= 0) then
		-- cancel the effect
		local idx = GET_STATUS_EFFECT_INDEX(characterIdx,STATUS_EFFECT_WALLOFFIRE);
		SET_STATUS_EFFECT_DURATION(characterIdx,idx,1);
	end
	

end


--	
--		DECLARE TABLE	
--

WallOfFired = {
	OnReceiveDamage = OnReceiveDamage,
	OnStartTurn = OnStartTurn,
};

