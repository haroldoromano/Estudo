--
--	HIDDEN
--		Deals double damage until he himself is damaged
--

local function OnGiveDamage(damage,sourceIdx,targetIdx)

	ADD_EFFECT_TO_CHARACTER(sourceIdx,"CyanSparkle");
	return damage * 2;
	
end


local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	-- cancel the effect
	local idx = GET_STATUS_EFFECT_INDEX(targetIdx,STATUS_EFFECT_HIDDEN);
	SET_STATUS_EFFECT_DURATION(targetIdx,idx,1);
	
	-- Actual effects
	ADD_EFFECT_TO_CHARACTER(targetIdx,"CyanSparkle");
	
	return damage;
end

--	
--		DECLARE TABLE	
--

Hidden = {
	OnReceiveDamage = OnReceiveDamage,
	OnGiveDamage = OnGiveDamage,
};

