---------------------------------------------------------
--	
--             Crazy Goblin	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Goblin in White Skull (WWSK)
-- 2 => Goblin in Snake Fang (WSFA)
-- 3 => Goblin in Northern Kor (WNKR)
-- 4 => Goblin in Bone Head (WBHE)
-- 5 => Goblin in Blood Moon (WRMO)
-- 6 => Goblin in Gork (WGRK)
-- 7 => Goblin in Drong's Tower (WDRT)
-- 8 => Got relic - can return to Gruuldok (CGRU)
-- 9 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local keptItem = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1S4";
local myOrigin   = "CGRU";
local myLocation1 = "WWSK";
local myLocation2 = "WSFA";
local myLocation3 = "WNKR";
local myLocation4 = "WBHE";
local myLocation5 = "WRMO";
local myLocation6 = "WGRK";
local myLocation7 = "WDRT";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	keptItem = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	keptItem = 0;
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 9;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1S4_NAME]");
	local myMessage;
	if (keptItem == 0) then
		 myMessage = GET_TEXT("[QUEST_Q1S4_REWARD]");
	else
		 myMessage = GET_TEXT("[QUEST_Q1S4_REWARDKEEP]");
	end

	QUEST_REWARD_MENU(myTitle,myMessage);

	if (keptItem == 0) then
		QUEST_REWARD_GOLD(250);
		QUEST_REWARD_XP(100);
	else
		QUEST_REWARD_ITEM("IROY");
	end
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
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation1 and questState==1) then
			return GET_TEXT("[QUEST_Q1S4_ACTION]");
	elseif (idLocation==myLocation2 and questState==2) then
			return GET_TEXT("[QUEST_Q1S4_ACTION]");
	elseif (idLocation==myLocation3 and questState==3) then
			return GET_TEXT("[QUEST_Q1S4_ACTION]");
	elseif (idLocation==myLocation4 and questState==4) then
			return GET_TEXT("[QUEST_Q1S4_ACTION]");
	elseif (idLocation==myLocation5 and questState==5) then
			return GET_TEXT("[QUEST_Q1S4_ACTION]");
	elseif (idLocation==myLocation6 and questState==6) then
			return GET_TEXT("[QUEST_Q1S4_ACTION]");
	elseif (idLocation==myLocation7 and questState==7) then
			return GET_TEXT("[QUEST_Q1S4_ACTION]");
	elseif (idLocation==myOrigin and questState==8) then
			return GET_TEXT("[QUEST_Q1S4_RETURN]");
	elseif (idLocation==myLocation7 and questState==8) then
			return GET_TEXT("[QUEST_Q1S4_KEEP]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState<7) then
		local myTitle = GET_TEXT("[QUEST_Q1S4_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q1S4_FAILURE]");
		QUEST_MESSAGE(myTitle ,myMessage ,idLocation);
		questState = questState + 1;
		QUEST_UPDATE_MAP();
	elseif (questState==7) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1S4a.xml",idLocation);
		questState = questState + 1;
		QUEST_UPDATE_MAP();
	elseif (questState==8 and idLocation==myOrigin) then
		keptItem = 0;
		QUEST_COMPLETE(myCode);
	elseif (questState==8 and idLocation==myLocation7) then
		keptItem = 1;
		QUEST_COMPLETE(myCode);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

end

---------------------------------------------------------
--
-- OnLoad				
--		(a save game is being loaded)
--
local function OnLoad()
	questState = QUEST_LOAD_INT();
	keptItem  = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(keptItem);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState < 8) then
		return GET_TEXT("[QUEST_Q1S4_STEP1]");
	elseif (questState == 8) then
		return GET_TEXT("[QUEST_Q1S4_STEP2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1) * 12;
end

---------------------------------------------------------
--
-- OnQueryDifficulty	
--		(returns 0-4 for difficulty - v.easy to v.difficult )
--
local function OnQueryDifficulty()
	-- average
	return 1; 
end

---------------------------------------------------------
--
-- CallbackConvA 	
--		Callback for a conversation
--
local function CallbackConvA()
	local myTitle = GET_TEXT("[QUEST_Q1S4_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1S4_SUCCESS]");
	QUEST_MESSAGE(myTitle ,myMessage ,myLocation7 );
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1S4 = {
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
};












