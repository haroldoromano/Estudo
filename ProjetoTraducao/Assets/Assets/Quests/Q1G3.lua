---------------------------------------------------------
--	
--             Reassembly	
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
local keptAxe = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1G3";
local myLocation = "CGAL";
local myOrigin   = "CGRU";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	keptAxe = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	keptAxe = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1G3a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1G3_NAME]");
	if (keptAxe == 0) then
		local myMessage = GET_TEXT("[QUEST_Q1G3_REWARD]");
		QUEST_ADD_AWARD("AMME");
		QUEST_REWARD_MENU(myTitle,myMessage);
		QUEST_REWARD_GOLD(1000);
		QUEST_REWARD_XP(50);
	else
		local myMessage = GET_TEXT("[QUEST_Q1G3_REWARD2]");
		QUEST_REWARD_MENU(myTitle,myMessage);
		QUEST_REWARD_ITEM("ISTA");
	end
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
	QUEST_UPDATE_MAP();
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
			return GET_TEXT("[QUEST_Q1G3_ACTION]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q1G3_RETURN]");
	elseif (idLocation==myLocation and questState==2) then
			return GET_TEXT("[QUEST_Q1G3_RETURN2]");
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
		local myTitle = GET_TEXT("[QUEST_Q1G3_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q1G3_TRADE]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		questState = 2;
		QUEST_UPDATE_MAP();
	elseif (questState==2 and idLocation==myOrigin) then
		keptAxe = 0;
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1G3b.xml",idLocation);
	elseif (questState==2 and idLocation==myLocation) then
		keptAxe = 1;
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
		return GET_TEXT("[QUEST_Q1G3_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1G3_STEP2]");
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
	return 1; 
end

-- CallbackConvB 				
--		(Callback fn - for end of conv)
--
local function CallbackConvB ()
	-- Reward
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1G3 = {
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

	CallbackConvB = CallbackConvB ,
};













