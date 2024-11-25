--
--	FLAMING HELM
--		Gives +8 Red Mana at the start of a battle 	
--


local function OnStartBattle(characterIdx)
	ADD_MANA_FIRE(characterIdx,8);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IFLH = {
	OnStartBattle = OnStartBattle,
};



