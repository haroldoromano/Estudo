--
--	LONGBOW
--		+2 Green and Yellow Mana on a 2+ Hit 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 2) then 
	
		ADD_MANA_AIR(sourceIdx,2);
		ADD_MANA_EARTH(sourceIdx,2);
		ADD_EFFECT_TO_CHARACTER(characterIdx,"YellowSparkle");
		NOTIFY_OF_ACTIVATED_ITEM();
			
	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--

IELB = {
	OnGiveDamage = OnGiveDamage,
};







