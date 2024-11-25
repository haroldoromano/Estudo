--
--	MASSIVE CLUB
--		+3 Damage 	&  +3 Earth Mastery
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + 3;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == SKILL_EARTH) then
		value = value + 3;
	end
	return value;
end


--	
--		DECLARE TABLE	
--

IMCL = {
	OnGiveDamage = OnGiveDamage,
	OnQuerySkill = OnQuerySkill,
};


