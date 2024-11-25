---------------------------------------------------------
--	
--             Family Reunion	
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
local myCode        = "Q0T0";
local myLocation    = "WSIR";
local myOrigin      = "CBAR";

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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0T0a.xml",myOrigin);
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
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (idLocation==myLocation) then
		QUEST_MESSAGE_CALLBACK(GET_TEXT("[QUEST_Q0T0_NAME]"),
								GET_TEXT("[QUEST_Q0T0_SIRIA]"),
								idLocation, myCode,"CallbackMessage");
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q0T0_ACTION]");
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0T0b.xml",idLocation);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

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
		return GET_TEXT("[QUEST_Q0T0_STEP1]");
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
	-- easy
	return 0; 
end

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_SET_VISIBILITY("WSIR",1);
	QUEST_SET_VISIBILITY("WTHR",1);
	QUEST_SET_VISIBILITY("WELE",1);
	QUEST_SET_VISIBILITY("WGIL",1);
	
	QUEST_UPDATE_MAP();
	
	if (TUTORIAL_ACTIVE()==1) then
		TUTORIAL_OPEN("QuestMove");
	end
	
end

local function CallbackConvB ()
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0T0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0T0_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage,myCode,"CallbackReward");
	QUEST_REWARD_ITEM("IBSH");
	QUEST_REWARD_XP(1);
end

local function CallbackMessage ()
	if (TUTORIAL_ACTIVE()==1) then
		TUTORIAL_OPEN("QuestAction");
	end
end

local function CallbackReward ()
	if (TUTORIAL_ACTIVE()==1) then
		TUTORIAL_OPEN("QuestMoreQuests");
	end
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0T0 = {
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
	CallbackMessage = CallbackMessage ,
	CallbackReward = CallbackReward ,
};











