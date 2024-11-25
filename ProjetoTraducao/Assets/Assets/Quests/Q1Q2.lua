---------------------------------------------------------
--	
--             Ogre Tactics	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Killed Monster #1
-- 3 => Killed Monster #2 - must return
-- 4 => Finished 
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local hadOgreMessage = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1Q2";
local myLocation = "WGRK";
local myOrigin   = "CDKO";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	hadOgreMessage = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	hadOgreMessage = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q2a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1Q2_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1Q2_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(400);
	QUEST_REWARD_XP(90);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (idLocation == myLocation and hadOgreMessage == 0) then
		hadOgreMessage = 1;
		local myTitle = GET_TEXT("[QUEST_Q1Q2_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q1Q2_OGRES]");
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
		return GET_TEXT("[QUEST_Q1Q2_ACTION1]");
	elseif (idLocation==myLocation and questState==2) then
		return GET_TEXT("[QUEST_Q1Q2_ACTION2]");
	elseif (idLocation==myOrigin and questState==3) then
		return GET_TEXT("[QUEST_Q1Q2_ACTION3]");
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q2b.xml",idLocation);
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
	
		local myTitle = GET_TEXT("[QUEST_Q1Q2_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q1Q2_SUCCESS1]");
			questState = 2;
		else
			myMessage = GET_TEXT("[QUEST_Q1Q2_FAILURE1]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		QUEST_UPDATE_MAP();
			
	elseif (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q1Q2_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q1Q2_SUCCESS2]");
			questState = 3;
		else
			myMessage = GET_TEXT("[QUEST_Q1Q2_FAILURE2]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
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
	hadOgreMessage = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(hadOgreMessage);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState==1) then
		return GET_TEXT("[QUEST_Q1Q2_PROGRESS1]");
	elseif (questState==2) then
		return GET_TEXT("[QUEST_Q1Q2_PROGRESS2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState - 1) * 33;
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
	QUEST_SET_VISIBILITY(myLocation ,1);
end

-- CallbackConvB 				
--		(Callback fn - for end of quest)
--
local function CallbackConvB ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1Q2 = {
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
};


















