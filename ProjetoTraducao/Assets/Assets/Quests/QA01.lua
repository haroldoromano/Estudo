---------------------------------------------------------
--	
--             Seeking Advice	
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
local myCode        = "QA01";
local myLocation    = "WMAE";
local myOrigin      = "CDKO";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QA01a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 2;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_QA01_NAME]");
	local myMessage = GET_TEXT("[QUEST_QA01_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(125);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;
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
			return GET_TEXT("[QUEST_QA01_ACTION]");
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
		if (QUEST_HERO_HAS_COMPANION_SELECTED("NDKH")==0) then
			local myTitle = GET_TEXT("[QUEST_QA01_NAME]");
			local myMessage = GET_TEXT("[QUEST_QA01_NOCOMP]");
			QUEST_MESSAGE(myTitle,myMessage,myLocation);
		else
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_QA01b.xml",idLocation);
		end
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_QA01c.xml",myLocation);
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
		return GET_TEXT("[QUEST_QA01_STEP1]");
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
	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	QUEST_BATTLE(myCode,0,1);
end

local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

QA01 = {
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
	CallbackConvB = CallbackConvB ,
	CallbackConvC = CallbackConvC ,
};






