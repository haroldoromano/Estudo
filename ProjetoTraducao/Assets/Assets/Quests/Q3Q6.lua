---------------------------------------------------------
--	
--             Bane&apos;s Citadel	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Killed Monster #1
-- 3 => Killed Monster #2, finished
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
local myCode     = "Q3Q6";
local myLocation = "CLBC";
local myOrigin   = "CLBC";

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
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NKHA")==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q6a.xml",myOrigin);
	else
		QUEST_UPDATE_MAP();
	end
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3Q6_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3Q6_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(500);
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
		return GET_TEXT("[QUEST_Q3Q6_ACTION1]");
	elseif (idLocation==myLocation and questState==2) then
		return GET_TEXT("[QUEST_Q3Q6_ACTION2]");
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
	
		local myTitle = GET_TEXT("[QUEST_Q3Q6_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q3Q6_SUCCESS1]");
			questState = 2;
			QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackMsgA");
		else
			myMessage = GET_TEXT("[QUEST_Q3Q6_FAILURE1]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
		end
		QUEST_UPDATE_MAP();
			
	elseif (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q3Q6_NAME]");
		local myMessage;
		if (success == 1) then
			if (QUEST_HERO_HAS_AWARD("AIMM")==0) then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q6c.xml",idLocation);
			else
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q6cc.xml",idLocation);
			end
		else
			myMessage = GET_TEXT("[QUEST_Q3Q6_FAILURE2]");
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
	if (questState==1) then
		return GET_TEXT("[QUEST_Q3Q6_PROGRESS1]");
	elseif (questState==2) then
		return GET_TEXT("[QUEST_Q3Q6_PROGRESS2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState - 1) * 50;
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
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end

local function CallbackMsgA ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NDKH") == 1 and
		QUEST_HERO_HAS_COMPANION_SELECTED("NKHA") == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q6b.xml",myOrigin);
	end 
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3Q6 = {
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

	CallbackMsgA = CallbackMsgA ,
};




















