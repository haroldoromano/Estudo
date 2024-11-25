--
--	LONGBOW
--		+3 Yellow Mana on a 3+ Hit 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 3) then 
	
		ADD_MANA_AIR(sourceIdx,3);
		ADD_EFFECT_TO_CHARACTER(characterIdx,"YellowSparkle");
		NOTIFY_OF_ACTIVATED_ITEM();
			
	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--

ILBW = {
	OnGiveDamage = OnGiveDamage,
};




