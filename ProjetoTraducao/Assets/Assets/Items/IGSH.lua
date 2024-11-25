--
--	GRUULKAR'S SHIELD
--		Adds +1 Battle on 2+ damage 	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 2) then 
		ADD_TEMP_SKILL(targetIdx,SKILL_BATTLE,1);
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IGSH = {
	OnReceiveDamage = OnReceiveDamage,
};




