--
--	FAVORED
--		1XP = 50% chance of Healing
--


local function OnReceiveXP(value,characterIdx)

	if (not IS_GAME_OVER()) then
		local i;
		local amt_heal = 0;
		for i = 1,value do
			if (PERCENTILE_CHANCE_SYNC() <= 50) then
				amt_heal = amt_heal + 1;
			end
		end
		if (amt_heal > 0) then
			ADD_LIFE(characterIdx,amt_heal);
			ADD_EFFECT_TO_CHARACTER(characterIdx,"CyanSparkle");
		end
	end
	
	return value;
end

--	
--		DECLARE TABLE	
--

Favored = {
	OnReceiveXP = OnReceiveXP,
};

