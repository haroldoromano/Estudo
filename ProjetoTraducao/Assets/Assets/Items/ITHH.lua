--
--	THEIRAN HAMMER
--		+2 Damage & turns one blue gem to yellow when it hits 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 3) then 
		damage = damage + 2;
	
		local x,y;
		x,y = GetRandomGrid_Type(GEM_BLUE);
		if (GET_GEM(x,y) == GEM_BLUE) then
			SET_GEM(x,y,GEM_YELLOW);
			ADD_EFFECT_TO_GRID(x,y,"YellowSparkle");
		end
		
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--

ITHH = {
	OnGiveDamage = OnGiveDamage,
};



