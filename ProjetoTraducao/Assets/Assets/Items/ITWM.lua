--
--	MAGE TOWER
--		City Item (Posn #0 - Tower)
--		Adds +maxMana/2 to damage	
--




------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage > 1) then
		local maxMana1 = GET_MANA_AIR(sourceIdx);
		local maxMana2 = GET_MANA_EARTH(sourceIdx);
		local maxMana3 = GET_MANA_FIRE(sourceIdx);
		local maxMana4 = GET_MANA_WATER(sourceIdx);
		if (maxMana1 >= maxMana2  and maxMana1 >= maxMana3  and maxMana1 >= maxMana4) then
			damage = damage+maxMana1 /2;
		elseif (maxMana2 >= maxMana1  and maxMana2 >= maxMana3  and maxMana2 >= maxMana4) then
			damage = damage+maxMana2 /2;
		elseif (maxMana3 >= maxMana1  and maxMana3 >= maxMana2  and maxMana3 >= maxMana4) then
			damage = damage+maxMana3 /2;
		else
			damage = damage+maxMana4 /2;
		end 
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

ITWM = {
	OnGiveDamage = OnGiveDamage,
};











