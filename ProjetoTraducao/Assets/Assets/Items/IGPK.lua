--
--	GNOLL PACK
--		XXX when owner gets XP	

------------------------------------------------
--
-- OnReceiveXP
--
--    Called whenever a character receives XP
--    Must return the amount of xp received (value)
--
local function OnReceiveXP(value,characterIdx)
	if (not IS_GAME_OVER()) then
		local mySkill = GET_RANDOM_SYNC(0,6);
		ADD_TEMP_SKILL(characterIdx, mySkill, value); 
		NOTIFY_OF_ACTIVATED_ITEM();

		if ( mySkill == SKILL_EARTH) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDEARTH]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_GREEN);	
		elseif ( mySkill == SKILL_FIRE) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDFIRE]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_RED);
		elseif ( mySkill == SKILL_AIR ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDAIR]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_YELLOW);	
		elseif ( mySkill == SKILL_WATER ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDWATER]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_CYAN);	
		elseif ( mySkill == SKILL_BATTLE ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDBATTLE]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_WHITE);	
		elseif ( mySkill == SKILL_CUNNING ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDCUNNING]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_ORANGE);	
		elseif ( mySkill == SKILL_MORALE ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDMORALE]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_PURPLE);
		end
	
	end
	return 0;
end

------------------------------------------------
--
-- OnReceiveGold
--
--    Called whenever a character receives Gold
--    Must return the amount of Gold received (value)
--
local function OnReceiveGold(value,characterIdx)

	if (not IS_GAME_OVER()) then

		local mySkill = GET_RANDOM_SYNC(0,6);
		ADD_TEMP_SKILL(characterIdx, mySkill, value); 
		NOTIFY_OF_ACTIVATED_ITEM();

		if ( mySkill == SKILL_EARTH) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDEARTH]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_GREEN);	
		elseif ( mySkill == SKILL_FIRE) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDFIRE]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_RED);
		elseif ( mySkill == SKILL_AIR ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDAIR]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_YELLOW);	
		elseif ( mySkill == SKILL_WATER ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDWATER]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_CYAN);	
		elseif ( mySkill == SKILL_BATTLE ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDBATTLE]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_WHITE);	
		elseif ( mySkill == SKILL_CUNNING ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDCUNNING]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_ORANGE);	
		elseif ( mySkill == SKILL_MORALE ) then
			local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_ADDMORALE]",value);
			ADD_TEXT_MESSAGE_TO_CHARACTER(characterIdx, msg,2,MESSAGE_PURPLE);
		end
	end
	
	return value;
end


--




--	
--		DECLARE TABLE	
--

IGPK = {
	OnReceiveGold = OnReceiveGold,
	OnReceiveXP = OnReceiveXP,
};








