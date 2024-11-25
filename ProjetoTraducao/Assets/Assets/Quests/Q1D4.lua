---------------------------------------------------------
--	
--             Serpent Meat	
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

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1D4";
local myLocation = "CDRA";
local myOrigin   = "CGLK";
local myEnd      = "WDRT";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1D4a.xml",myOrigin);
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
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q1D4_ACTION]");
	elseif (idLocation==myEnd and questState==2) then
			return GET_TEXT("[QUEST_Q1D4_RETURN]");
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
	elseif (questState==2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1D4b.xml",idLocation);
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
	
		local myTitle = GET_TEXT("[QUEST_Q1D4_NAME]");
		local myMessage;
		if (success == 1) then
	  		questState = 2;
			myMessage = GET_TEXT("[QUEST_Q1D4_KILL]");
		else
			myMessage = GET_TEXT("[QUEST_Q1D4_FAILURE]");
		end
		QUEST_MESSAGE(myTitle,myMessage,myLocation);
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
		return GET_TEXT("[QUEST_Q1D4_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1D4_STEP2]");
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
	return 2; 
end

-- CallbackConvA 				
--		(Callback fn - for end of conv)
--
local function CallbackConvA ()
end

-- CallbackConvB 				
--		(Callback fn - for end of conv)
--
local function CallbackConvB ()
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1D4_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1D4_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage, myCode,"CallbackCompanion");
	QUEST_REWARD_XP(150);
end


local function CallbackCompanion ()
	QUEST_ADD_COMPANION("NDRO");
	QUEST_COMPANION_MESSAGE("NDRO");
	QUEST_COMPLETE(myCode);
end



---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1D4 = {
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
	CallbackCompanion = CallbackCompanion,
};







