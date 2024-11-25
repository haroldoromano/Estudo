--
--	CIRCLET OF SKULLS
--		Randomly creates a skull at beginning of each of your turns 	
--


local function OnStartTurn(characterIdx,turnNumber)

	if (turnNumber <= 1) then
		return;
	end
	if (PERCENTILE_CHANCE_SYNC() < 50) then
		return;
	end

	-- Find a grid without a skull on it (and no skulls adjacent!)
	local x,y = GetRandomGrid_Isolated2(5,15);
	
	-- Change it
	SET_GEM(x,y,5);				
	ADD_EFFECT_TO_GRID(x,y,"WhiteSparkle");
	PLAY_SOUND("snd_misceffect");
	
	NOTIFY_OF_ACTIVATED_ITEM();
	
	return;
end

--	
--		DECLARE TABLE	
--

ICOS = {
	OnStartTurn = OnStartTurn,
};



