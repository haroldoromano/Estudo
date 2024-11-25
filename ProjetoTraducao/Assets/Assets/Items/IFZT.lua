--
--	FROZEN STAFF
--		Blue Mana % chance for the enemy to lose a turn 	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	if (damage >= 2) then 
	
		if (PERCENTILE_CHANCE_SYNC() <= GET_MANA_WATER(sourceIdx)) then
		
			-- Message
			local numTurns = 2;
			local displayedTurns = numTurns -1;
			local msg_turn = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_MISSTURN1]",displayedTurns);
			ADD_TEXT_MESSAGE_TO_CHARACTER(targetIdx,msg_turn,2,6);
			PLAY_SOUND("snd_stun");
			
			-- Effect
			MISS_TURNS(targetIdx,numTurns);
			NOTIFY_OF_ACTIVATED_ITEM();
			
		end	
	end
	
	return damage;
end

--	
--		DECLARE TABLE	
--

IFZT = {
	OnGiveDamage = OnGiveDamage,
};




