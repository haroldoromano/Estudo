--
--	SEREPHINE'S RING
--		Removes status effects on a match4/5	
--

local function DoEffect(characterIdx)
	CLEAR_STATUS_EFFECTS(characterIdx);
	ADD_EFFECT_TO_CHARACTER(characterIdx,"GreenSparkle");
	NOTIFY_OF_ACTIVATED_ITEM();
end


------------------------------------------------
--
-- OnMatch4
--
--    Called whenever a character matches 4
--    gems (and receives an extra turn)
--
local function OnMatch4(characterIdx)
	DoEffect(characterIdx);
end

------------------------------------------------
--
-- OnMatch5
--
--    Called whenever a character matches 5
--    gems (and receives an extra turn + wildcard)
--
local function OnMatch5(characterIdx)
	DoEffect(characterIdx);
end



--	
--		DECLARE TABLE	
--

ISRI = {
	OnMatch5 = OnMatch5,
	OnMatch4 = OnMatch4,
};






