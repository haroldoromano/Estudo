--
--	DEATHSHROUD
--		Every 8 points dmg --> 1 Random Red Skull 	
--

-- Track the skulls per turn
IDSH_numSkulls = {};


local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	if (IDSH_numSkulls[targetIdx] == nil) then
		IDSH_numSkulls[targetIdx] = 0;
	end

	local numSkulls = damage/8;
	if (numSkulls+IDSH_numSkulls[targetIdx] > 3) then
		numSkulls = 3-IDSH_numSkulls[targetIdx];
	end
	IDSH_numSkulls[targetIdx] = IDSH_numSkulls[targetIdx] + numSkulls;

	if (numSkulls > 0 and damage >= 8) then 
		local i,x,y;
		local didEffect = false;
		for i = 1,numSkulls do
			x,y = GetRandomGrid_Not3(GEM_SKULL,GEM_REDSKULL,GEM_EMPTY);
			if (GET_GEM(x,y)~=GEM_EMPTY) then
				SET_GEM(x,y,GEM_REDSKULL);				
				ADD_EFFECT_TO_GRID(x,y,"RedSparkle");
				didEffect = true;
			end
		end
		if (didEffect) then
			PLAY_SOUND("snd_stone");
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage;
end

------------------------------------------------
--
-- OnStartTurn
--
--    Called at the start of player turn
--    before the turn is actually started
--
local function OnStartTurn(characterIdx,turnNumber)
	IDSH_numSkulls[characterIdx] = 0;
end



--	
--		DECLARE TABLE	
--

IDSH = {
	OnStartTurn = OnStartTurn,
	OnReceiveDamage = OnReceiveDamage,
};










