---------------------------------------------------------
--	
--             Ill gotten gains	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, Found tracks leading to the Pike
-- 2 => Found tracks leading to Tusk
-- 3 => Found tracks leading to Weret
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
local myCode        = "QP01";
local myLocation1    = "WPIK";
local myLocation2    = "CTSK";
local myLocation3    = "WWRT";
local myOrigin      = "CHYA";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QP01a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_QP01_NAME]");
	local myMessage = GET_TEXT("[QUEST_QP01_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(300);
	QUEST_REWARD_XP(200);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState=0;
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
	if(questState==1 and idLocation==myLocation1 and 
		QUEST_HERO_HAS_COMPANION_SELECTED("NPAT")==1) then

		return GET_TEXT("[QUEST_QP01_ACTION1]");

	elseif(questState==2 and idLocation==myLocation2 and 
		QUEST_HERO_HAS_COMPANION_SELECTED("NPAT")==1) then

		return GET_TEXT("[QUEST_QP01_ACTION1]");

	elseif(questState==3 and idLocation==myLocation3 and 
		QUEST_HERO_HAS_COMPANION_SELECTED("NPAT")==1) then

		return GET_TEXT("[QUEST_QP01_ACTION2]");

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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_QP01b.xml",myLocation1);

	elseif(questState==2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_QP01c.xml",myLocation2);

	elseif(questState==3) then
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

	if (questState==3) then
	
		local myMessage;
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_QP01d.xml",myLocation3);
		else
			local myTitle = GET_TEXT("[QUEST_QP01_NAME]");
			local myMessage = GET_TEXT("[QUEST_QP01_FAILURE]");
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
		return GET_TEXT("[QUEST_QP01_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_QP01_STEP2]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_QP01_STEP3]");
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
	elseif (questState <= 2) then
		return 33;
	elseif (questState <= 3) then
		return 66;
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

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	questState = 2;
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	questState = 3;
	QUEST_SET_VISIBILITY(myLocation3,1);
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

QP01 = {
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


















