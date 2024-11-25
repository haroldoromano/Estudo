--
--	RING OF AIR
--		3 Green Mana gives 1 yellow 	
--


local function OnReceiveMana(value,characterIdx,manaType)
	if (manaType == 0) then
		local extraMana = value/3;
		if (extraMana > 0) then
			ADD_MANA_AIR(characterIdx, extraMana);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return value;
end

--	
--		DECLARE TABLE	
--

IROA = {
	OnReceiveMana = OnReceiveMana,
};


