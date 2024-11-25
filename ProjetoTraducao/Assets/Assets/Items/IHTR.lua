--
--	HORN OF TRIUMPH
--		+50 XP on victory 	
--


local function OnVictory(characterIdx)
	ADD_XP(characterIdx,50);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IHTR = {
	OnVictory = OnVictory,
};


