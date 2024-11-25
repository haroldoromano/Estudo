---------------------------------------------------------
--	
--             Lord of Orcs	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Nothing done yet
-- 2 => Talked to Orc Guard
-- 3 => Got Warg Pelt
-- 4 => Complete
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
local myCode     = "Q1Q1";
local myOrigin   = "CDKO";
local myDest0    = "WSFA";
local myDest1    = "CGRU";
local myDest2    = "RWGS";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q1a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1Q1_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1Q1_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(80);
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
	if (idLocation == myDest1 and questState == 1) then
		return GET_TEXT("[QUEST_Q1Q1_ACTION0]");
	elseif (idLocation == myDest2 and questState == 2) then
		return GET_TEXT("[QUEST_Q1Q1_ACTION1]");
	elseif (idLocation == myDest1 and questState == 3) then
		return GET_TEXT("[QUEST_Q1Q1_ACTION0]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (idLocation == myDest1 and questState == 1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q1b.xml",myOrigin);
		questState = 2;
	elseif (idLocation == myDest2 and questState == 2) then
		QUEST_BATTLE_NOCAPTURE(myCode,0,1);
	elseif (idLocation == myDest1 and questState == 3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q1c.xml",myOrigin);
		questState = 4;
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==2 and idLocation==myDest2) then
	
		local myTitle = GET_TEXT("[QUEST_Q1Q1_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q1Q1_SUCCESS]");
			questState = 3;
			QUEST_SET_RUIN_DONE(myDest2);
		else
			myMessage = GET_TEXT("[QUEST_Q1Q1_FAILURE]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
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
	if (questState <= 1) then
		return GET_TEXT("[QUEST_Q1Q1_HELP0]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1Q1_HELP1]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q1Q1_HELP2]");
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
		return 40;
	elseif (questState == 3) then
		return 80;
	end
	return 40;
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

-- CallbackConvA 				
--		(Callback fn - for end of quest)
--
local function CallbackConvA ()
	QUEST_SET_VISIBILITY(myDest1 ,1);
	Std_AddEncounter(myDest0,myDest1,"EGRO");
end

-- CallbackConvB 				
--		(Callback fn - for end of quest)
--
local function CallbackConvB ()
	QUEST_ADD_RUIN(myDest2);
	QUEST_UPDATE_MAP();
end

-- CallbackConvC 				
--		(Callback fn - for end of quest)
--
local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1Q1 = {
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
















