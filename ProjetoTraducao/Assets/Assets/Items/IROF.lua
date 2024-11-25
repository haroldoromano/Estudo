--
--	RING OF FIRE
--		3 Blue Mana gives 1 Red 	
--


local function OnReceiveMana(value,characterIdx,manaType)
	if (manaType == 3) then
		local extraMana = value/3;
		if (extraMana > 0) then
			ADD_MANA_FIRE(characterIdx, extraMana);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return value;
end

--	
--		DECLARE TABLE	
--

IROF = {
	OnReceiveMana = OnReceiveMana,
};


