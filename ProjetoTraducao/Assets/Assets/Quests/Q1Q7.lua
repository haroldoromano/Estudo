---------------------------------------------------------
--	
--             Dragontrap	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Talked to Flicker
-- 3 => Complete
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
local myCode     = "Q1Q7";
local myLocation = "WNKR";
local myLocation2= "WDPS";
local myLocation3= "CDRH";
local myOrigin   = "CDKO";


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
	QUEST_SET_VISIBILITY(myLocation ,1);
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q7a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1Q7_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1Q7_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(150);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (questState == 1 and idLocation==myLocation) then
		local myTitle = GET_TEXT("[QUEST_Q1Q7_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q1Q7_MSGA]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		QUEST_STOP_MOVEMENT();
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q1Q7_ACTION0]");
	elseif (idLocation==myLocation3 and questState==2) then
			return GET_TEXT("[QUEST_Q1Q7_ACTION1]");
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q7b.xml",idLocation);
	elseif (questState==2) then
		local myTitle = GET_TEXT("[QUEST_Q1Q7_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q1Q7_MSGB]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,"Q1Q7","CallbackMsgB");
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState == 2) then
	
		local myTitle = GET_TEXT("[QUEST_Q1Q7_NAME]");
		local myMessage;
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q7c.xml",idLocation);
		else
			myMessage = GET_TEXT("[QUEST_Q1Q7_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,myLocation);
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
		return GET_TEXT("[QUEST_Q1Q7_PROGRESS1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1Q7_PROGRESS2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*50;
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

-- Callbacks				
--		(Callback fn - for end of quest/message)
--
local function CallbackConvB ()
	questState = 2;
	QUEST_SET_VISIBILITY(myLocation2 ,1);
	QUEST_SET_VISIBILITY(myLocation3 ,1);
	QUEST_UPDATE_MAP();
end
local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end
local function CallbackMsgB ()
	QUEST_BATTLE(myCode,0,1);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1Q7 = {
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

	CallbackConvB = CallbackConvB,
	CallbackConvC = CallbackConvC,
	CallbackMsgB = CallbackMsgB,
};















