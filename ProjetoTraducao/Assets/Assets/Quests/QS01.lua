---------------------------------------------------------
--	
--             Shotgun Wedding	
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

---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "QS01";
local myLocation    = "CTRA";
local myOrigin      = "CENM";

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
	QUEST_SET_VISIBILITY(myLocation,1);
	QUEST_UPDATE_MAP();
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 2;
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState=0;
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
			return GET_TEXT("[QUEST_QS01_ACTION]");
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
	
		local myMessage;
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_QS01a.xml",idLocation);
		else
			local myTitle = GET_TEXT("[QUEST_QS01_NAME]");
			local myMessage = GET_TEXT("[QUEST_QS01_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
			QUEST_UPDATE_MAP();
		end
	end
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
	if (questState == 1) then
		return GET_TEXT("[QUEST_QS01_STEP1]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState <= 1) then
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

local function CallbackConvA ()
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_QS01_NAME]");
	local myMessage = GET_TEXT("[QUEST_QS01_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage, myCode,"CallbackCompanion");
	QUEST_REWARD_GOLD(100);
	QUEST_REWARD_XP(100);
end

local function CallbackCompanion ()
	QUEST_ADD_COMPANION("NSER");
	QUEST_COMPANION_MESSAGE("NSER");
	QUEST_COMPLETE(myCode);
end
---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

QS01 = {
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
	
	CallbackConvA = CallbackConvA ,
	CallbackCompanion = CallbackCompanion,
};





















