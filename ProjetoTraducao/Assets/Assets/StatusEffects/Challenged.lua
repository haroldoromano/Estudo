--
--	CHALLENGED
--		If both players are under challenge... all damnage is at +50%
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (HAS_STATUS_EFFECT(sourceIdx,STATUS_EFFECT_CHALLENGED) and
	    HAS_STATUS_EFFECT(targetIdx,STATUS_EFFECT_CHALLENGED)) then 
		damage = damage + (damage/2);
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

Challenged = {
	OnGiveDamage = OnGiveDamage,
};

