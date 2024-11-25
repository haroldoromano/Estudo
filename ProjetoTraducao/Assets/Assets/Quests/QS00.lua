---------------------------------------------------------
--	
--             Secret Message	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Had conversation with Selentius, but not fight
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
local myCode        = "QS00";
local myLocation    = "CENM";
local myOrigin      = "CHTP";


--calls Conv_QS00b
local function ConvB()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QS00b.xml",myLocation);	
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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QS00a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_QS00_NAME]");
	local myMessage = GET_TEXT("[QUEST_QS00_REMOVECOMP]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(10);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if(questState==1 and idLocation==myLocation) then

		local myTitle = GET_TEXT("[QUEST_QS00_NAME]");
		if (QUEST_HERO_HAS_COMPANION_SELECTED("NSER")==0) then

			local myMessage = GET_TEXT("[QUEST_QS00_NOCOMP]");
			QUEST_MESSAGE_CALLBACK(myTitle,myMessage,myLocation);
		else
			QUEST_REMOVE_COMPANION("NSER");
			local myMessage = GET_TEXT("[QUEST_QS00_PRELUDE]");
			QUEST_MESSAGE_CALLBACK(myTitle,myMessage,myLocation,myCode,"ConvB");
		end
			
	elseif (questState==2 and idLocation==myLocation) then

		local myTitle = GET_TEXT("[QUEST_QS00_NAME]");
		local myMessage = GET_TEXT("[QUEST_QS00_REENTER]");
		QUEST_MESSAGE(myTitle,myMessage,myLocation);
			
	end
end


---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_QS00_RETCOMP]");
	elseif (idLocation==myLocation and questState==2) then
			return GET_TEXT("[QUEST_QS00_ACTION]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (idLocation == myLocation and questState==1) then
		local myTitle = GET_TEXT("[QUEST_QS00_NAME]");
		local myMessage = GET_TEXT("[QUEST_QS00_NOCOMP]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation);
	elseif (idLocation == myLocation and questState==2) then
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

	if (questState==1 or questState==2) then
		local myTitle = GET_TEXT("[QUEST_QS00_NAME]");	
		local myMessage;	
		--Whether succeed of fail - display Kidnapped message.
		if(success==1) then
			myMessage = GET_TEXT("[QUEST_QS00_REWARD]");
			
		else
			myMessage = GET_TEXT("[QUEST_QS00_FAILURE]");
			
		end
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,myLocation,myCode,"CompleteQ");
		
		
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
		return GET_TEXT("[QUEST_QS00_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_QS00_STEP2]");
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

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	questState = 2;
	QUEST_BATTLE(myCode,0,1);
end

local function CompleteQ()
	QUEST_COMPLETE(myCode);
	QUEST_UPDATE_MAP();
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

QS00 = {
	OnInit				= OnInit,
	OnBegin				= OnBegin,
	OnEnd				= OnEnd,
	OnAbandon			= OnAbandon,
	OnEnterLocation		= OnEnterLocation,
	OnExecuteAction		= OnExecuteAction,
	OnCompleteAction	= OnCompleteAction,
	OnQueryAvailable	= OnQueryAvailable,
	OnQueryAction		= OnQueryAction,
	OnLoad				= OnLoad,
	OnSave				= OnSave,
	OnQueryProgress		= OnQueryProgress,
	OnQueryPercentage	= OnQueryPercentage,
	OnQueryDifficulty	= OnQueryDifficulty,
	
	CallbackConvA = CallbackConvA ,
	CallbackConvB = CallbackConvB ,
	ConvB	= ConvB,
	CompleteQ = CompleteQ,
};




































































