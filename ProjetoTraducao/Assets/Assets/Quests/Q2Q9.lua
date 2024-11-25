---------------------------------------------------------
--	
--             Skull of Sartek	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Monster defeated, must return
-- 3 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local doneFlickerConv = 0;
local doneMinogothConv = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "Q2Q9";
local myLocation    = "COHT";
local myOrigin      = "CHTP";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	doneFlickerConv = 0;
	doneMinogothConv = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	doneFlickerConv = 0;
	doneMinogothConv = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q9a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
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
	if (idLocation == myLocation and doneFlickerConv == 0 and
		QUEST_HERO_HAS_COMPANION_SELECTED("NFLI")==1) then

		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q9b.xml",idLocation);
		
	end
		
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q2Q9_ACTION]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q2Q9_RETURN]");
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
		if (doneMinogothConv == 0) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q9c.xml",idLocation);
		else
			QUEST_BATTLE(myCode,0,1);
		end
	elseif (questState==2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q9e.xml",idLocation);
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
	
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q9d.xml",idLocation);
		else
			local myTitle = GET_TEXT("[QUEST_Q2Q9_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q2Q9_FAILURE]");
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
	doneFlickerConv = QUEST_LOAD_INT();
	doneMinogothConv = QUEST_LOAD_INT(); 
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(doneFlickerConv);
	QUEST_SAVE_INT(doneMinogothConv);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q2Q9_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q2Q9_STEP2]");
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
	elseif (questState == 2) then
		return 50;
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
	return 3; 
end

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_SET_VISIBILITY(myLocation ,1);
	QUEST_SET_CITY_STATUS(myLocation ,3);
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	doneFlickerConv = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	doneMinogothConv = 1;
	QUEST_BATTLE_NOCAPTURE(myCode,0,1);
end

local function CallbackConvD ()
	local myTitle = GET_TEXT("[QUEST_Q2Q9_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2Q9_KILL]");
	QUEST_MESSAGE(myTitle,myMessage,myLocation);
	questState = 2;
	QUEST_UPDATE_MAP();
end

local function CallbackConvE ()
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2Q9_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2Q9_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage,myCode,"CallbackReward");
	QUEST_REWARD_XP(600);
	QUEST_REWARD_ITEM("IAOM");

	QUEST_SET_CITY_STATUS(myLocation ,0);
end

local function CallbackReward ()
	QUEST_CUTSCENE("CutScenes\\Chap4_Intro.xml");
	QUEST_UPDATE_MAP();
	QUEST_COMPLETE(myCode);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2Q9 = {
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
	CallbackConvE = CallbackConvE ,
	CallbackReward = CallbackReward ,
};















