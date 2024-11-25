--
--	AXE OF RED-AXE
--		+5 Fire Mastery & Fire Resistance
--		+2 damage if damage is 3+	
--




------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)
	if (manaIdx == MANA_RED) then
		value = value + 5;
	end
	return value;
end

------------------------------------------------
--
-- OnQuerySkill
--
--    Called whenever the game accesses a skill
--    Must return the value of the skill
--    Skill index is one of SKILL_EARTH, SKILL_FIRE,etc...
--
local function OnQuerySkill(value,characterIdx,skillIdx)
	if (skillIdx == SKILL_FIRE) then
		value = value + 5;
	end
	return value;
end

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
		damage = damage + 2;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage
end




--	
--		DECLARE TABLE	
--

IAOR = {
	OnGiveDamage = OnGiveDamage,
	OnQuerySkill = OnQuerySkill,
	OnQueryResistance = OnQueryResistance,
};







