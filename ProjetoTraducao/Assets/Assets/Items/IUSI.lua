--
--	UNICORN SHIELD
--		+15 Healing when you match 5 gems	
--


------------------------------------------------
--
-- OnMatch5
--
--    Called whenever a character matches 5
--    gems (and receives an extra turn + wildcard)
--
local function OnMatch5(characterIdx)
      Std_Healing(15,characterIdx);
	NOTIFY_OF_ACTIVATED_ITEM();
end


--	
--		DECLARE TABLE	
--

IUSI = {
	OnMatch5 = OnMatch5,
};








