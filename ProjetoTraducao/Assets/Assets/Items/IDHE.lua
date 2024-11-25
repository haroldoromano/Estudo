--
--	DROWNING HELM
--		Gives +10 Blue Mana at the start of a battle 	
--


local function OnStartBattle(characterIdx)
	ADD_MANA_WATER(characterIdx,10);
	NOTIFY_OF_ACTIVATED_ITEM();
	return;
end

--	
--		DECLARE TABLE	
--

IDHE = {
	OnStartBattle = OnStartBattle,
};





