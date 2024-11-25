--
--	SYSRUS DARKHUNTER
--		An Elf who hunts Undead.	
--


------------------------------------------------
--
-- OnStartBattle
--
--    A battle has just started
--    This is called before the first turn
--
local function OnStartBattle(characterIdx)

	-- find the other character
	local otherIdx = 1;
	local amt = 10;
	if (characterIdx == 1) then
		otherIdx = 0;
	end

	-- check the type
	if (CHECK_TYPE(otherIdx,"Undead") == 1) then

		SUBTRACT_LIFE(otherIdx ,amt,characterIdx);
	
		-- Special FX on enemy
		local msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE2]",amt);
		ADD_TEXT_MESSAGE_TO_CHARACTER(otherIdx ,msg_damage,2,6);
		PLAY_SOUND("snd_redskull");

		ACTIVATE_COMPANION("NDKH");
	end
	return;
end




--	
--		DECLARE TABLE	
--

NDKH = {
   OnStartBattle = OnStartBattle,
};














