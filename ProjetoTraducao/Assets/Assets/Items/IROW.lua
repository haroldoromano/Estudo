--
--	RING OF WATER
--		3 Yellow Mana gives 1 Blue 	
--


local function OnReceiveMana(value,characterIdx,manaType)
	if (manaType == 2) then
		local extraMana = value/3;
		if (extraMana > 0) then
			ADD_MANA_WATER(characterIdx, extraMana);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return value;
end

--	
--		DECLARE TABLE	
--

IROW = {
	OnReceiveMana = OnReceiveMana,
};


