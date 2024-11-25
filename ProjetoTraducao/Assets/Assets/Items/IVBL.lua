--
--	FLAMEBLADE
--		+NumRedGems/2 Damage 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + CountGems(GEM_RED)/2;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IVBL = {
	OnGiveDamage = OnGiveDamage,
};





