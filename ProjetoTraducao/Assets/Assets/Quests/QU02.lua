---------------------------------------------------------
--	
--             A Worthy Foe	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Monster defeated, must return in 7 days
-- 3 => 7 days is up, must return
-- 3 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local targetDate = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "QU02";
local myLocation    = "WRAG";
local myOrigin      = "CEHL";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	targetDate = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QU02a.xml",myOrigin);
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
	if (questState==2 and QUEST_GET_DATE() >= targetDate) then
		questState = 3;	
		QUEST_UPDATE_MAP();
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_QU02_ACTION]");
	elseif (idLocation==myLocation and questState==3) then
			return GET_TEXT("[QUEST_QU02_RETURN]");
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
		if (QUEST_HERO_HAS_COMPANION_SELECTED("NSUN")==0) then
			local myTitle = GET_TEXT("[QUEST_QU02_NAME]");
			local myMessage = GET_TEXT("[QUEST_QU02_NOCOMP]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
		else
			QUEST_BATTLE(myCode,0,1);
		end
	elseif (questState==3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_QU02c.xml",idLocation);
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
	  		questState = 2;
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_QU02b.xml",idLocation);
		else
			local myTitle = GET_TEXT("[QUEST_QU02_NAME]");
			local myMessage = GET_TEXT("[QUEST_QU02_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
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
	targetDate = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(targetDate );
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_QU02_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_QU02_STEP2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*33;
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
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	QUEST_REMOVE_COMPANION("NSUN");
 	targetDate = QUEST_GET_DATE() + 7;
	QUEST_UPDATE_MAP();

	local myTitle = GET_TEXT("[QUEST_QU02_NAME]");
	local myMessage = GET_TEXT("[QUEST_QU02_COMPLEFT]");
	QUEST_MESSAGE(myTitle,myMessage,idLocation);

end

local function CallbackConvC ()
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_QU02_NAME]");
	local myMessage = GET_TEXT("[QUEST_QU02_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage,myCode,"CallbackCompanion");
	QUEST_REWARD_XP(300);
end

local function CallbackCompanion ()
	QUEST_ADD_COMPANION("NSUS");
	QUEST_COMPANION_MESSAGE("NSUS");
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

QU02 = {
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
	CallbackCompanion = CallbackCompanion ,
};










