--
--	RING OF EARTH
--		3 Red Mana gives 1 Green 	
--


local function OnReceiveMana(value,characterIdx,manaType)
	if (manaType == 1) then
		local extraMana = value/3;
		if (extraMana > 0) then
			ADD_MANA_EARTH(characterIdx, extraMana);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return value;
end

--	
--		DECLARE TABLE	
--

IROE = {
	OnReceiveMana = OnReceiveMana,
};



