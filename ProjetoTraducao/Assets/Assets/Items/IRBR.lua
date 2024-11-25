--
--	RUBY RING
--		Triples gold from matching gems 	
--


local function OnReceiveGold(value,characterIdx)
	value = value*3;
	NOTIFY_OF_ACTIVATED_ITEM();
	return value;
end

--	
--		DECLARE TABLE	
--

IRBR = {
	OnReceiveGold = OnReceiveGold,
};


