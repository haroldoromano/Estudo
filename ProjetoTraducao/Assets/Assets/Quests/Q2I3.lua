---------------------------------------------------------
--	
--             Endless War 	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local myLocation = "WPIK";
local fallbackLocation = "WPIK";
local myOrigin   = "CTSK";
local currLocal  = 1;


---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q2I3";
local locations = {"WWRT","CHTP","CHYA","CJAK",
"WPIK","WGWK","WSHD","WHBG","CTSK"};
local maxLocal  = 9;

local function GetLocation(rseed)
	local location = myOrigin;
	local currLocal = 1;
	local i = 0;
	-- get random location - check if visible
	repeat
		currLocal = GET_RANDOM(1,maxLocal);
		location = locations[currLocal];
		i = i + 1;
	until ((QUEST_IS_VISIBLE(location) == 1 and location ~= myOrigin) or i >= 2*maxLocal)

	--if location not visible - fallback to a safe place 
	if (QUEST_IS_VISIBLE(location) == 0) then
		location = fallbackLocation;
	end

	return location;
end
---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	myLocation = GetLocation(QUEST_GET_DATE());	
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 0;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2I3_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2I3_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(200);
	QUEST_REWARD_XP(150);

	myLocation = GetLocation(QUEST_GET_DATE()); -- new location for quest

end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
	myLocation = GetLocation(QUEST_GET_DATE()); --Reset Location
	QUEST_UPDATE_MAP();
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q2I3_ACTION]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState==1) then
		QUEST_BATTLE(myCode,0,1);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==1) then
	
		local myTitle = GET_TEXT("[QUEST_Q2I3_NAME]");
		local myMessage;
		if (success == 1) then
	  		QUEST_COMPLETE(myCode);
		else
			myMessage = GET_TEXT("[QUEST_Q2I3_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,myLocation);

			myLocation = GetLocation(QUEST_GET_DATE()); --Reset Location
			
		end
		
	end
	QUEST_UPDATE_MAP();
end

---------------------------------------------------------
--
-- OnLoad				
--		(a save game is being loaded)
--
local function OnLoad()
	questState = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState < 2) then 
		return 0;
	end
	return 100;
end

---------------------------------------------------------
--
-- OnQueryDifficulty	
--		(returns 0-4 for difficulty - v.easy to v.difficult )
--
local function OnQueryDifficulty()
	-- average
	return 2; 
end



---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2I3 = {
	OnInit				= OnInit,
	OnBegin				= OnBegin,
	OnEnd				= OnEnd,
	OnAbandon			= OnAbandon,
	OnEnterLocation		= OnEnterLocation,
	OnExecuteAction		= OnExecuteAction,
	OnCompleteAction	= OnCompleteAction,
	OnQueryAction		= OnQueryAction,
	OnLoad				= OnLoad,
	OnSave				= OnSave,
	OnQueryProgress		= OnQueryProgress,
	OnQueryPercentage	= OnQueryPercentage,
	OnQueryDifficulty	= OnQueryDifficulty,
};
















































































































