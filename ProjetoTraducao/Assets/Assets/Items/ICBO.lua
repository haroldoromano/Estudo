--
--	CENTAUR'S BOW
--		+1 Yellow Mana & Damage on a 2+ hit 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 3) then 
	
		ADD_MANA_AIR(sourceIdx,1);
		damage = damage + 1;
		ADD_EFFECT_TO_CHARACTER(characterIdx,"YellowSparkle");
		NOTIFY_OF_ACTIVATED_ITEM();
			
	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--

ICBO = {
	OnGiveDamage = OnGiveDamage,
};



