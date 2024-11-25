---------------------------------------------------------
--	
--             Slave Trail	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Met Tauron
-- 3 => Visited The Pike
-- 4 => Tried to enter, but now must fight a Firewalker
-- 5 => Finished
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
local myCode     = "Q2Q0";
local myDestination = "WPIK";
local myLocation = "CHTP";
local myOrigin   = "CHTP";


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
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 5;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2Q0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2Q0_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(100);
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

	local myTitle = GET_TEXT("[QUEST_Q2Q0_NAME]");
	local myMessage;

	if (questState==2 and idLocation==myDestination) then
		local myMessage = GET_TEXT("[QUEST_Q2Q0_MSG1]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		questState = 3;
		QUEST_UPDATE_MAP();
	elseif (questState==3 and idLocation==myLocation) then
		local myMessage = GET_TEXT("[QUEST_Q2Q0_MSG2]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
		return GET_TEXT("[QUEST_Q2Q0_ACTION]");
	elseif (idLocation==myDestination and questState==2) then
		return GET_TEXT("[ON]");
	elseif (idLocation==myLocation and questState==3) then
		return GET_TEXT("[QUEST_Q2Q0_ACTION]");
	elseif (idLocation==myLocation and questState==4) then
		return GET_TEXT("[QUEST_Q2Q0_ACTION4]");
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q0a.xml",idLocation);
	elseif (questState==3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q0b.xml",idLocation);
		questState=4;
		QUEST_UPDATE_MAP();
	elseif (questState==4) then
		QUEST_BATTLE_NOCAPTURE(myCode,0,1);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==4) then
	
		local myTitle = GET_TEXT("[QUEST_Q2Q0_NAME]");
		local myMessage;
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q0c.xml",idLocation);
		else
			myMessage = GET_TEXT("[QUEST_Q2Q0_FAILURE]");
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
		return GET_TEXT("[QUEST_Q2Q0_PROG1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q2Q0_PROG2]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q2Q0_PROG3]");
	elseif (questState == 4) then
		return GET_TEXT("[QUEST_Q2Q0_PROG4]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*25;
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

local function CallbackConvA ()
	questState = 2;
	QUEST_SET_VISIBILITY(myDestination ,1);
	Std_AddEncounter(myLocation ,myDestination,"EHP0")
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2Q0 = {
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
	CallbackConvC = CallbackConvC ,
};























