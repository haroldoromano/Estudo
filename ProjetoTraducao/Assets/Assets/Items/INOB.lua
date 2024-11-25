--
--	NECKLACE OF BONES
--		On 12+ damage, 2 Glowing skulls appear 	
--

-- Track the skulls per turn
INOB_numSkulls = {};



local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	if (INOB_numSkulls[targetIdx] == nil) then
		INOB_numSkulls[targetIdx] = 0;
	end

	local numSkulls = 0;
	if (damage >= 12) then
		numSkulls = 2;
	end
	if (numSkulls+INOB_numSkulls[targetIdx] > 2) then
		numSkulls = 2-INOB_numSkulls[targetIdx];
	end
	INOB_numSkulls[targetIdx] = INOB_numSkulls[targetIdx] + numSkulls;

	
	if (numSkulls > 0) then
	
		local amt=numSkulls;
		
		-- Find grids and DO IT!!!!
		local tries = 0;
		repeat
		
			local x,y = GetRandomGrid_Not3(GEM_SKULL,GEM_REDSKULL,GEM_EMPTY);
			amt = amt - 1;
			ADD_EFFECT_TO_GRID(x,y,"WhiteSparkle");
			SET_GEM(x,y,GEM_REDSKULL);
			tries = tries+1;
		until (tries > 1000 or amt <= 0)
		
		-- Effects
		PLAY_SOUND("snd_misceffect");
		
		NOTIFY_OF_ACTIVATED_ITEM();
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
	INOB_numSkulls[characterIdx] = 0;
end



--	
--		DECLARE TABLE	
--

INOB = {
	OnStartTurn = OnStartTurn,
	OnReceiveDamage = OnReceiveDamage,
};



