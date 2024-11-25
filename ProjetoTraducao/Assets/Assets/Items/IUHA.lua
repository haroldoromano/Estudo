--
--	UBERHAMMER
--		+5 Damage & turns one red gem to a skull when it hits 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 3) then 
		damage = damage + 5;
	
		local x,y;
		x,y = GetRandomGrid_Type(GEM_RED);
		if (GET_GEM(x,y) == GEM_RED) then
			SET_GEM(x,y,GEM_SKULL);
			ADD_EFFECT_TO_GRID(x,y,"RedSparkle");
		end
	
		NOTIFY_OF_ACTIVATED_ITEM();

	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--
IUHA = {
	OnGiveDamage = OnGiveDamage,
};



