---------------------------------------------------------
--	
--             The Mechataur	
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
local myCode     = "Q1Q9";
local myWaypoint = "WVOK";
local myLocation = "WHBG";
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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q9a.xml",myOrigin);
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
	if (idLocation == myLocation) then
		local myTitle = GET_TEXT("[QUEST_Q1Q9_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q1Q9_MECHATAUR]");
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
		return GET_TEXT("[QUEST_Q1Q9_ACTION]");
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

	if (questState==1) then
	
		local myTitle = GET_TEXT("[QUEST_Q1Q9_NAME]");
		local myMessage;
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q9b.xml",idLocation);
		else
			myMessage = GET_TEXT("[QUEST_Q1Q9_FAILURE]");
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
	if (questState < 2) then 
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


-- Callbacks				
--		(Callback fn - for end of quest/message)
--
local function CallbackConvA ()
	questState = 1;
	QUEST_SET_VISIBILITY(myWaypoint ,1);
	QUEST_SET_VISIBILITY(myLocation ,1);
	Std_AddEncounter(myWaypoint ,myLocation ,"EVOK")
	QUEST_UPDATE_MAP();
end
local function CallbackConvB ()	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1Q9_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1Q9_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage,myCode,"CallbackReward");
	QUEST_REWARD_XP(500);
	QUEST_REWARD_ITEM("IEGM");

	QUEST_SET_VISIBILITY("CHTP" ,1);
	QUEST_UPDATE_MAP();
end
local function CallbackReward ()
	QUEST_CUTSCENE("CutScenes\\Chap3_Intro.xml");
	QUEST_COMPLETE(myCode);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1Q9 = {
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

	CallbackConvA = CallbackConvA, 
	CallbackConvB = CallbackConvB, 
	CallbackReward = CallbackReward, 
};










