--
--	SKULL OF MINOGOTH
--		Power Description	
--


local function DestroyStars()

	-- Loop through each column
	DestroyAllGems(GEM_STAR, EFFECT_PURPLE_SPARKLE);
	
end

------------------------------------------------
--
-- OnMatch4
--
--    Called whenever a character matches 4
--    gems (and receives an extra turn)
--
local function OnMatch4(characterIdx)
	DestroyStars();
	NOTIFY_OF_ACTIVATED_ITEM();
end

------------------------------------------------
--
-- OnMatch5
--
--    Called whenever a character matches 5
--    gems (and receives an extra turn + wildcard)
--
local function OnMatch5(characterIdx)
	DestroyStars();
	NOTIFY_OF_ACTIVATED_ITEM();
end



--	
--		DECLARE TABLE	
--

IMGS = {
	OnMatch5 = OnMatch5,
	OnMatch4 = OnMatch4,
};






