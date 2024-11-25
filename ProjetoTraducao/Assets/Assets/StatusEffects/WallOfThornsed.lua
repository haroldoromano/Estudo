--
--	WALL OF THORNSED
--		Damage comes off of green mana instead of life
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	-- The ideal case
	local green_mana = GET_MANA_EARTH(targetIdx);
	local mana_damage = damage;
	damage = 0;
	
	-- If we are nearing the end
	if (green_mana - mana_damage <= 0) then
		damage = mana_damage - green_mana;
		mana_damage = green_mana;
		
		-- cancel the effect
		local idx = GET_STATUS_EFFECT_INDEX(targetIdx,STATUS_EFFECT_WALLOFTHORNS);
		SET_STATUS_EFFECT_DURATION(targetIdx,idx,1);
	end
	
	-- Actual effects
	if (mana_damage > 0) then
		SUBTRACT_MANA_EARTH(targetIdx,mana_damage);
		ADD_EFFECT_TO_CHARACTER(targetIdx,"GreenSparkle");
	end
	
	
	return damage;
end

local function OnStartTurn(characterIdx,turnNumber)

	SUBTRACT_MANA_EARTH(characterIdx,2);
	
	-- If we are nearing the end
	if (GET_MANA_EARTH(characterIdx) <= 0) then
		-- cancel the effect
		local idx = GET_STATUS_EFFECT_INDEX(characterIdx,STATUS_EFFECT_WALLOFTHORNS);
		SET_STATUS_EFFECT_DURATION(characterIdx,idx,1);
	end
	

end


--	
--		DECLARE TABLE	
--

WallOfThornsed = {
	OnReceiveDamage = OnReceiveDamage,
	OnStartTurn = OnStartTurn,
};

