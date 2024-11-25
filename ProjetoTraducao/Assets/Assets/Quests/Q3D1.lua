---------------------------------------------------------
--	
--             Dragontracks	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Visited Skullguard Keep
-- 3 => Visited BoneBridge
-- 4 => Visited Bane's Citadel
-- 5 => Monster not defeated, but may return
-- 6 => Monster defeated, must return
-- 7 => Finished
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
local myCode        = "Q3D1";
local myLocation    = "CLBC";
local myWaypoint1   = "WSGK";
local myWaypoint2   = "WBBR";
local myOrigin      = "CYLA";

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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3D1a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3D1_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3D1_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(200);
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
	if (idLocation==myLocation and questState==3) then
			return GET_TEXT("[QUEST_Q3D1_ACTION]");
	elseif (idLocation==myLocation and questState==4) then
			return GET_TEXT("[QUEST_Q3D1_ACTION]");
	elseif (idLocation==myLocation and questState==5) then
			return GET_TEXT("[QUEST_Q3D1_ACTION2]");
	elseif (idLocation==myOrigin and questState > 4) then --state 5or6 allow to return
			return GET_TEXT("[QUEST_Q3D1_RETURN]");
	elseif (idLocation==myWaypoint1 and questState==1) then
			return GET_TEXT("[QUEST_Q3D1_ACTION]");
	elseif (idLocation==myWaypoint2 and questState==2) then
			return GET_TEXT("[QUEST_Q3D1_ACTION]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState==1 and idLocation==myWaypoint1) then
		questState = 2;
		local myTitle = GET_TEXT("[QUEST_Q3D1_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q3D1_NOSIGN]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		QUEST_UPDATE_MAP();
	
	elseif (questState==2 and idLocation==myWaypoint2) then
		questState = 3;
		local myTitle = GET_TEXT("[QUEST_Q3D1_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q3D1_TRACKS]");
		if (QUEST_IS_VISIBLE(myLocation)==0) then
			QUEST_SET_VISIBILITY(myLocation,1);
			QUEST_SET_CITY_STATUS(myLocation,CITYSTATUS_CLOSED);
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		QUEST_UPDATE_MAP();
	
	elseif (questState==3 and idLocation==myLocation) then
		questState = 4;
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3D1b.xml",idLocation);
	
	elseif (questState==5 and idLocation==myLocation) then

		QUEST_BATTLE(myCode,0,1);

	elseif (questState >4 and idLocation==myOrigin) then

		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3D1c.xml",idLocation);
	
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState > 3) then
	
		local myTitle = GET_TEXT("[QUEST_Q3D1_NAME]");
		local myMessage;
		if (success == 1) then
	  		questState = 6;
			myMessage = GET_TEXT("[QUEST_Q3D1_KILL]");
		else
			questState = 5;
			myMessage = GET_TEXT("[QUEST_Q3D1_FAILURE]");
		end
		QUEST_MESSAGE(myTitle,myMessage,myLocation);
		QUEST_UPDATE_MAP();
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
		return GET_TEXT("[QUEST_Q3D1_STEP1]");
	elseif (questState == 5) then
		return GET_TEXT("[QUEST_Q3D1_STEP2]");
	elseif (questState == 6) then
		return GET_TEXT("[QUEST_Q3D1_STEP3]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*16;
end

---------------------------------------------------------
--
-- OnQueryDifficulty	
--		(returns 0-4 for difficulty - v.easy to v.difficult )
--
local function OnQueryDifficulty()
	-- average
	return 3; 
end

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	QUEST_BATTLE(myCode,0,1);
	questState = 5; -- better set it here in case they cancel
end

local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3D1 = {
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

























