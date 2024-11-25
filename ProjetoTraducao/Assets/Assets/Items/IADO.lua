--
--	AXE OF DOOM
--		+1 damage and destroys all red skulls	
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
	if (damage >= 3) then
		-- damage effect
		damage = damage + 1;

		-- skull effect
		SetMultiplierEffects(false);
		local x,y,gt,typ,chance;
		for y = 1,8 do
			for x = 1,8 do
				gt = GET_GEM(x,y);
				if (gt == GEM_REDSKULL) then
					DESTROY_GEM(x,y);		
				end
			end
		end
		SetMultiplierEffects(true);

		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end


--	
--		DECLARE TABLE	
--

IADO = {
	OnGiveDamage = OnGiveDamage,
};







