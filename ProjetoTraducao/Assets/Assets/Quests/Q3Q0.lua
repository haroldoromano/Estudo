---------------------------------------------------------
--	
--             Gornak&apos;s Gap	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Had Bane conv
-- 3 => Monster defeated, must return
-- 4 => Finished
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
local myCode        = "Q3Q0";
local myLocation    = "WGGP";
local myOrigin      = "COHT";

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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q0a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3Q0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3Q0_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(325);
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
	if (questState == 1 and idLocation == myLocation) then
		QUEST_STOP_MOVEMENT();
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q0b.xml",idLocation);
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==2) then
			return GET_TEXT("[QUEST_Q3Q0_ACTION0]");
	elseif (idLocation==myLocation and questState==3) then
			return GET_TEXT("[QUEST_Q3Q0_ACTION1]");
	elseif (idLocation==myOrigin and questState==3) then
			return GET_TEXT("[QUEST_Q3Q0_RETURN]");
	elseif (idLocation=="CLBC" and questState==1) then
			return GET_TEXT("[ON]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState==2) then
		QUEST_BATTLE(myCode,0,1);
	elseif (questState==3 and idLocation == myLocation) then
		QUEST_MESSAGE(GET_TEXT("[QUEST_Q3Q0_NAME]"),GET_TEXT("[QUEST_Q3Q0_FAILURE1]"),idLocation);
	elseif (questState==3 and idLocation == myOrigin) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q0d.xml",idLocation);
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
	
		local myTitle = GET_TEXT("[QUEST_Q3Q0_NAME]");
		local myMessage;
		if (success == 1) then
			if (QUEST_HERO_HAS_COMPANION_SELECTED("NSUN")==1) then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q0c.xml",idLocation);
			else
				QUEST_MESSAGE_CALLBACK(myTitle,GET_TEXT("[QUEST_Q3Q0_KILL]"),idLocation,myCode,"CallbackConvC");
			end
		else
			myMessage = GET_TEXT("[QUEST_Q3Q0_FAILURE0]");
			QUEST_MESSAGE(myTitle,myMessage,myLocation);
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
		return GET_TEXT("[QUEST_Q3Q0_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q3Q0_STEP2]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q3Q0_STEP3]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*33;
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

	QUEST_SET_VISIBILITY("WSMZ",1);
	QUEST_SET_VISIBILITY(myLocation,1); -- Gornaks Gap
	QUEST_SET_VISIBILITY("WGRW",1);
	QUEST_SET_VISIBILITY("WSOI",1);
	QUEST_SET_VISIBILITY("CLBC",1);
	QUEST_SET_CITY_STATUS("CLBC",CITYSTATUS_CLOSED);

	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	questState = 2;

	QUEST_MESSAGE(GET_TEXT("[QUEST_Q3Q0_NAME]"),GET_TEXT("[QUEST_Q3Q0_BANEMSG]"),myLocation);
	QUEST_SET_VISIBILITY("WGRW",0);
	QUEST_SET_VISIBILITY("WSOI",0);
	QUEST_SET_VISIBILITY("CLBC",0);
	QUEST_ENCOUNTER_REMOVE_AT("WGRW",myLocation);
	QUEST_ENCOUNTER_REMOVE_AT("CLBC","WSOI");

	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	questState = 3;
	QUEST_UPDATE_MAP();
end

local function CallbackConvD ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3Q0 = {
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
	CallbackConvD = CallbackConvD ,
};











