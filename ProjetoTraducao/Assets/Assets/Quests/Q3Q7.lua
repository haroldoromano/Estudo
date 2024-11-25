---------------------------------------------------------
--	
--             The Final Battle	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Monster defeated, finished
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
local myCode        = "Q3Q7";
local myLocation    = "CLBC";
local myOrigin      = "CLBC";

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
	if (QUEST_HERO_HAS_AWARD("AIMM")==0) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q7a.xml",myOrigin);
	else
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q7aa.xml",myOrigin);
	end
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	QUEST_ROLL_CREDITS();
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
			return GET_TEXT("[QUEST_Q3Q7_ACTION]");
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
	
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q7c.xml",idLocation);
		else
			local myTitle = GET_TEXT("[QUEST_Q3Q7_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q3Q7_FAILURE]");
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
		return GET_TEXT("[QUEST_Q3Q7_STEP1]");
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
	-- average
	return 3; 
end

---------------------------------------------------------

-- note the order of conversations here: A -> C -> B

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end


local function CallbackConvB ()
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3Q7_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3Q7_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage,myCode,"CallbackEnd");
	QUEST_REWARD_GOLD(1000);
	QUEST_REWARD_XP(2000);

	QUEST_SET_CITY_STATUS("CLBC",CITYSTATUS_AVAILABLE);
end

local function CallbackConvC ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NDRO")==1) then
		local myTitle = GET_TEXT("[QUEST_Q3Q7_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q3Q7_HUNGRY]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,myLocation,myCode,"CallbackDrong");
	else
		CallbackConvB();
	end
end

local function CallbackDrong ()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q7b.xml",myLocation);
end

local function CallbackEnd ()
	if (QUEST_HERO_HAS_AWARD("AIMM")==0) then
		QUEST_CUTSCENE("CutScenes\\Chap4_End_good.xml");
	else
		QUEST_CUTSCENE("CutScenes\\Chap4_End_evil.xml");
	end
	QUEST_COMPLETE(myCode);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3Q7 = {
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
	CallbackEnd = CallbackEnd ,
	CallbackDrong = CallbackDrong ,
};

























