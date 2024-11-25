--
--	GREAT AXE
--		50% extra turn when doing 5+ damage 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 5) then 
		local chance = PERCENTILE_CHANCE_SYNC();
		if (chance <= 50) then
			EXTRA_TURN(1,1);
			local msg = GET_TEXT("[EXTRATURN]");
			ADD_TEXT_MESSAGE2(msg,2,6);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IGAX = {
	OnGiveDamage = OnGiveDamage,
};



