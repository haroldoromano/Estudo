---------------------------------------------------------
--	
--             Waking Kelthurax	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Made noise - nothing happened
-- 3 => Finished
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
local myCode     = "Q1Q8";
local myLocation = "CDRH";
local myOrigin   = "CDRH";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q8a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1Q8_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1Q8_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(250);
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
end


---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q1Q8_ACTION]");
	elseif (idLocation==myLocation and questState==2) then
			return GET_TEXT("[QUEST_Q1Q8_ACTION1]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)

	local myTitle = GET_TEXT("[QUEST_Q1Q8_NAME]");
	local myMessage;

	if (questState==1) then
		myMessage= GET_TEXT("[QUEST_Q1Q8_MSGA]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackMsgA");
	elseif (questState==2) then
		myMessage= GET_TEXT("[QUEST_Q1Q8_MSGB]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackMsgB");
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q1Q8_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q1Q8_MSGC]");
			QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackMsgC");
		else
			myMessage = GET_TEXT("[QUEST_Q1Q8_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
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
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*50 ;
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
local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end
local function CallbackConvB ()
	QUEST_COMPLETE(myCode);
end
local function CallbackMsgA ()
	questState = 2;
	QUEST_UPDATE_MAP();
end
local function CallbackMsgB ()
	QUEST_BATTLE(myCode,0,1);
end
local function CallbackMsgC ()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q8b.xml",myOrigin);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1Q8 = {
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
	CallbackMsgA  = CallbackMsgA ,
	CallbackMsgB  = CallbackMsgB ,
	CallbackMsgC  = CallbackMsgC ,
};







