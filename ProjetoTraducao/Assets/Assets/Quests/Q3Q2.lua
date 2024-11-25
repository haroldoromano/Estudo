---------------------------------------------------------
--	
--             Ylarie Defence	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Killed Monster #1
-- 3 => Killed Monster #2
-- 4 => Killed Monster #3
-- 5 => Killed Monster #4 (finished)
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
local myCode     = "Q3Q2";
local myOrigin   = "CYLA";

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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q2a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 5;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3Q2_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3Q2_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(250);
	QUEST_REWARD_XP(350);
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
	if (idLocation==myOrigin) then
		return GET_TEXT("[QUEST_Q3Q2_ACTION]");
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
		QUEST_BATTLE(myCode,0,1);
	elseif (questState==2) then
		QUEST_BATTLE(myCode,1,1);
	elseif (questState==3) then
		QUEST_BATTLE(myCode,2,1);
	elseif (questState==4) then
		QUEST_BATTLE(myCode,3,1);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)
	
	local myTitle = GET_TEXT("[QUEST_Q3Q2_NAME]");

	if (success	== 0) then

		local myMessage = GET_TEXT("[QUEST_Q3Q2_FAILURE]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);

	elseif (questState==1) then
	
		local myMessage = GET_TEXT("[QUEST_Q3Q2_SUCCESS1]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		questState = 2;
		QUEST_UPDATE_MAP();
			
	elseif (questState==2) then
	
		local myMessage = GET_TEXT("[QUEST_Q3Q2_SUCCESS2]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackMsg2");
		QUEST_UPDATE_MAP();
		
	elseif (questState==3) then
	
		local myMessage = GET_TEXT("[QUEST_Q3Q2_SUCCESS3]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackMsg3");
		QUEST_UPDATE_MAP();
		
	elseif (questState==4) then
	
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q2d.xml",myOrigin);
		
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
	return GET_TEXT("[QUEST_Q3Q2_PROGRESS1]");
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState - 1) * 25;
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

	local myTitle = GET_TEXT("[QUEST_Q3Q2_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3Q2_PROGRESS1]");
	QUEST_MESSAGE(myTitle,myMessage,myOrigin);

	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	questState = 3;
	QUEST_UPDATE_MAP();
end


local function CallbackConvC ()
	questState = 4;
	QUEST_UPDATE_MAP();
end


local function CallbackConvD ()
	QUEST_COMPLETE(myCode);
end


local function CallbackMsg2 ()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q2b.xml",myOrigin);
end

local function CallbackMsg3 ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NDKH")==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q2c.xml",myOrigin);
	else
		questState = 4;
		QUEST_UPDATE_MAP();
	end
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3Q2 = {
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
	CallbackConvC = CallbackConvC,
	CallbackConvD = CallbackConvD,

	CallbackMsg2 = CallbackMsg2,
	CallbackMsg3 = CallbackMsg3,
};
















