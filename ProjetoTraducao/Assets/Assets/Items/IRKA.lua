--
--	RAT KING'S AMULET
--		Gain 3 Gold every time you get Blue Mana 	
--


local function OnReceiveMana(value,characterIdx,manaType)
	if (manaType == MANA_BLUE) then
		ADD_GOLD(characterIdx, 3);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IRKA = {
	OnReceiveMana = OnReceiveMana,
};



