--
--	HELM OF THE RAM
--		+2 damage on damage of 3+	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + 2;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IHRA = {
	OnGiveDamage = OnGiveDamage,
};
 

