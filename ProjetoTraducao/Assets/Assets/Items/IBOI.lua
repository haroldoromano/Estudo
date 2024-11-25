--
--	BOILING OIL
--		City Item (Special, Pos #4)
--		Adds +4 to damage if 8+ Red Gems are in play	

------------------------------------------------
--
-- OnGiveDamage
--
--    Called whenever a character does damage
--    Must return the amount of damage done
--     sourceIdx = attacker  targetIdx=me!
--
local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (CountGems(GEM_RED) >= 8) then
		damage = damage + 4;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end






--	
--		DECLARE TABLE	
--

IBOI = {
	OnGiveDamage = OnGiveDamage,
};




