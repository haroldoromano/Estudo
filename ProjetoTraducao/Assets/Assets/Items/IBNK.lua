--
--	BANES CLOAK
--		1% chance to heal 10 per 3 points of WATER
--



------------------------------------------------
--
-- OnStartTurn
--
--    Called at the start of player turn
--    before the turn is actually started
--
local function OnStartTurn(characterIdx,turnNumber)
	
	local myChance = GET_SKILL(sourceIdx,SKILL_WATER)/3;
	if (PERCENTILE_CHANCE_SYNC() < myChance) then
		Std_Healing(10, characterIdx);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
end




--	
--		DECLARE TABLE	
--

IBNK = {
	OnQueryResistance = OnQueryResistance,
};














