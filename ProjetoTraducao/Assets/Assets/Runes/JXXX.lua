--
--	RUNE ITEM
--		Handle all rune item powers in here	

------------------------------------------------
--
-- OnStartBattle
--
--    Called whenever a new battle is started
--    before the first player takes a turn
--
local function OnStartBattle(characterIdx)

	local powerCode = GET_CURRENT_RUNE_CODE(RUNE_POWER);
	
	-- "P0" => +6 Red Mana at start of battle
	if (powerCode == "0") then
		ADD_MANA_FIRE(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		NOTIFY_OF_ACTIVATED_ITEM();

	-- "P1" => +6 Green Mana at start of battle
	elseif (powerCode == "1") then
		ADD_MANA_EARTH(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
		
	-- "P2" => +6 Yellow Mana at start of battle
	elseif (powerCode == "2") then
		ADD_MANA_AIR(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
		
	-- "P3" => +6 Blue Mana at start of battle
	elseif (powerCode == "3") then
		ADD_MANA_WATER(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
		
		
	-- "P4" => +6 Life at start of battle
	elseif (powerCode == "4") then
		ADD_MAX_LIFE(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		ADD_LIFE(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
		
		
	end

end

------------------------------------------------
--
-- OnVictory
--
--    Called after a battle is ended
--    for the winning character only
--
local function OnVictory(characterIdx)

	local powerCode = GET_CURRENT_RUNE_CODE(RUNE_POWER);
	
	-- "PB" => 20 Gold on a victory
	if (powerCode == "B") then
	
		ADD_GOLD(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
	
	-- "PC" => 20 XP on a victory
	elseif (powerCode == "C") then
	
		ADD_XP(characterIdx,GET_CURRENT_RUNE_POWERDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
	
	end

end

------------------------------------------------
--
-- OnDefeat
--
--    Called after a battle is ended
--    for the losing character only
--
local function OnDefeat(characterIdx)

end

------------------------------------------------
--
-- OnStartTurn
--
--    Called at the start of player turn
--    before the turn is actually started
--
local function OnStartTurn(characterIdx,turnNumber)


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

	local baseCode = GET_CURRENT_RUNE_CODE(RUNE_BASE);
	
	-- "B2" => +3 Morale
	if (baseCode == "2") then
		if (skillIdx == SKILL_MORALE) then
			value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
	-- "B3" => +3 Battle
	elseif (baseCode == "3") then
		if (skillIdx == SKILL_BATTLE) then
			value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
	-- "B4" => +3 Cunning
	elseif (baseCode == "4") then
		if (skillIdx == SKILL_CUNNING) then
			value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
	-- "B5" => +3 Air Mastery
	elseif (baseCode == "5") then
		if (skillIdx == SKILL_AIR) then
			value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
		
	-- "B6" => +3 Earth Mastery
	elseif (baseCode == "6") then
		if (skillIdx == SKILL_EARTH) then
			value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
	-- "B7" => +3 Fire Mastery
	elseif (baseCode == "7") then
		if (skillIdx == SKILL_FIRE) then
			value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
	-- "B8" => +3 Water Mastery
	elseif (baseCode == "8") then
		if (skillIdx == SKILL_WATER) then
			value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
	--end

	-- "BA" => +1 all 4 masteries
	elseif (baseCode == "A") then
		if (skillIdx == SKILL_WATER or skillIdx == SKILL_FIRE or 
			skillIdx == SKILL_EARTH or skillIdx == SKILL_AIR) then
				value = value + GET_CURRENT_RUNE_BASEDATA();
		end
		
	end

	return value;
end

------------------------------------------------
--
-- OnQueryResistance
--
--    Called whenever the game needs to find a resistance
--    Must return the value of the resistance
--    The index is one of MANA_GREEN, MANA_RED, etc...
--
local function OnQueryResistance(value,characterIdx,manaIdx)

	local powerCode = GET_CURRENT_RUNE_CODE(RUNE_POWER);
	
	-- "P5" => +8% Water Resistance
	if (powerCode == "5") then
		if (manaIdx == MANA_BLUE) then
			value = value + GET_CURRENT_RUNE_POWERDATA();
		end
	
	-- "P6" => +8% Earth Resistance
	elseif (powerCode == "6") then
		if (manaIdx == MANA_GREEN) then
			value = value + GET_CURRENT_RUNE_POWERDATA();
		end
	
	-- "P7" => +8% Air Resistance
	elseif (powerCode == "7") then
		if (manaIdx == MANA_YELLOW) then
			value = value + GET_CURRENT_RUNE_POWERDATA();
		end
	
	-- "P8" => +8% Fire Resistance
	elseif (powerCode == "8") then
		if (manaIdx == MANA_RED) then
			value = value + GET_CURRENT_RUNE_POWERDATA();
		end
	
	
	end

	return value;
end

------------------------------------------------
--
-- OnCastSpell
--
--    Called whenever a character casts a spell
--
local function OnCastSpell(characterIdx)

end

------------------------------------------------
--
-- OnEnemyCastSpell
--
--    Called whenever an enemy casts a spell
--
local function OnEnemyCastSpell(characterIdx,enemyIdx)

	local baseCode = GET_CURRENT_RUNE_CODE(RUNE_BASE);
	
	-- "BB" => +1 Mana on enemy cast spell
	if (baseCode == "B") then
		ADD_MANA_AIR(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_WATER(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_EARTH(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_FIRE(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
		
	end
end

------------------------------------------------
--
-- OnExtraTurn
--
--    Called whenever a character receives
--    an extra turn
--
local function OnExtraTurn(characterIdx)

end

------------------------------------------------
--
-- OnMatch4
--
--    Called whenever a character matches 4
--    gems (and receives an extra turn)
--
local function OnMatch4(characterIdx)

	local baseCode = GET_CURRENT_RUNE_CODE(RUNE_BASE);
	
	-- "BC" => +1 Mana on enemy cast spell
	if (baseCode == "C") then
		ADD_MANA_AIR(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_WATER(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_EARTH(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_FIRE(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
		
	end
end

------------------------------------------------
--
-- OnMatch5
--
--    Called whenever a character matches 5
--    gems (and receives an extra turn + wildcard)
--
local function OnMatch5(characterIdx)

	local baseCode = GET_CURRENT_RUNE_CODE(RUNE_BASE);
	
	-- "BC" => +1 Mana on enemy cast spell
	if (baseCode == "C") then
		ADD_MANA_AIR(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_WATER(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_EARTH(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		ADD_MANA_FIRE(characterIdx, GET_CURRENT_RUNE_BASEDATA());
		NOTIFY_OF_ACTIVATED_ITEM();
		
	end
end

------------------------------------------------
--
-- OnReceiveDamage
--
--    Called whenever a character takes damage
--    Must return the amount of damage taken
--     sourceIdx = attacker  targetIdx=me!
--
local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	local baseCode = GET_CURRENT_RUNE_CODE(RUNE_BASE);
	
	-- "BE" => +1 damage to enemy when receiving 2+
	if (baseCode == "E") then
		if (damage >= 6 and sourceIdx ~= targetIdx) then 
			local reflDamage = GET_CURRENT_RUNE_BASEDATA();
			if (reflDamage >= damage) then
				reflDamage = damage;
			end
			SUBTRACT_LIFE(sourceIdx,reflDamage, targetIdx);
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end
	
	
	return damage
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

	local baseCode = GET_CURRENT_RUNE_CODE(RUNE_BASE);
	local powerCode = GET_CURRENT_RUNE_CODE(RUNE_POWER);
	
	-- "B0" => +1 damage for results overover 3+
	if (baseCode == "0") then
		if (damage >= 3) then 
			damage = damage + GET_CURRENT_RUNE_BASEDATA();
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	
	-- "B1" => +2 damage for results overover 3+
	elseif (baseCode == "1") then
		if (damage >= 3) then 
			damage = damage + GET_CURRENT_RUNE_BASEDATA();
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	
	-- "B9" => +3 damage for results overover 6+
	elseif (baseCode == "9") then
		if (damage >= 6) then 
			damage = damage + GET_CURRENT_RUNE_BASEDATA();
			NOTIFY_OF_ACTIVATED_ITEM();
		end
	
	
	-- "BD" => +2 damage for each mana reserve that is full
	elseif (baseCode == "D") then
	
		if (damage >= 3) then 
			local addDamage = 0;
			if (GET_MANA_AIR(sourceIdx) >= GET_MAX_MANA_AIR(sourceIdx)) then 
				addDamage = addDamage + GET_CURRENT_RUNE_BASEDATA();
			end
			if (GET_MANA_WATER(sourceIdx) >= GET_MAX_MANA_WATER(sourceIdx)) then 
				addDamage = addDamage + GET_CURRENT_RUNE_BASEDATA();
			end
			if (GET_MANA_EARTH(sourceIdx) >= GET_MAX_MANA_EARTH(sourceIdx)) then 
				addDamage = addDamage + GET_CURRENT_RUNE_BASEDATA();
			end
			if (GET_MANA_FIRE(sourceIdx) >= GET_MAX_MANA_FIRE(sourceIdx)) then 
				addDamage = addDamage + GET_CURRENT_RUNE_BASEDATA();
			end
			if (addDamage > 0) then
				damage = damage + addDamage;
				NOTIFY_OF_ACTIVATED_ITEM();
			end
		end
	
	end
	
	
	
	-- "P9" => 20% chance of poison
	if (powerCode == "9") then
		if (PERCENTILE_CHANCE_SYNC() <= GET_CURRENT_RUNE_POWERDATA()) then
			ADD_STATUS_EFFECT(targetIdx,"EPOI"); 
			ADD_EFFECT_TO_CHARACTER(targetIdx,"GreenSparkle");
			NOTIFY_OF_ACTIVATED_ITEM();
		end
		
		
	-- "PA" => 20% chance of disease
	elseif (powerCode == "A") then
		if (PERCENTILE_CHANCE_SYNC() <= GET_CURRENT_RUNE_POWERDATA()) then
			ADD_STATUS_EFFECT(targetIdx,"EDIS"); 
			ADD_EFFECT_TO_CHARACTER(targetIdx,"GreenSparkle");
			NOTIFY_OF_ACTIVATED_ITEM();
		end
		
		
	end
	
	return damage
end

------------------------------------------------
--
-- OnReceiveMana
--
--    Called whenever a character receives mana
--    Must return the amount of mana received (value)
--     manaType is one of MANA_GREEN, MANA_RED, etc...
--
local function OnReceiveMana(value,characterIdx,manaType)

	return value
end

------------------------------------------------
--
-- OnUseMana
--
--    Called whenever a character uses mana
--    Must return the amount of mana used (value)
--     manaType is one of MANA_GREEN, MANA_RED, etc...
--
local function OnUseMana(value,characterIdx,manaType)

	return value
end

------------------------------------------------
--
-- OnReceiveXP
--
--    Called whenever a character receives XP
--    Must return the amount of xp received (value)
--
local function OnReceiveXP(value,characterIdx)

	return value
end

------------------------------------------------
--
-- OnReceiveGold
--
--    Called whenever a character receives Gold
--    Must return the amount of Gold received (value)
--
local function OnReceiveGold(value,characterIdx)

	return value
end


--	
--		DECLARE TABLE	
--

JXXX = {
	OnReceiveGold = OnReceiveGold,
	OnReceiveXP = OnReceiveXP,
	OnUseMana = OnUseMana,
	OnReceiveMana = OnReceiveMana,
	OnGiveDamage = OnGiveDamage,
	OnReceiveDamage = OnReceiveDamage,
	OnMatch5 = OnMatch5,
	OnMatch4 = OnMatch4,
	OnExtraTurn = OnExtraTurn,
	OnEnemyCastSpell = OnEnemyCastSpell,
	OnCastSpell = OnCastSpell,
	OnQuerySkill = OnQuerySkill,
	OnQueryResistance = OnQueryResistance,
	OnStartTurn = OnStartTurn,
	OnDefeat = OnDefeat,
	OnVictory = OnVictory,
	OnStartBattle = OnStartBattle,
};



