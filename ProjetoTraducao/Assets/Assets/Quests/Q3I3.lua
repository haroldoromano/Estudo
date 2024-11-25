---------------------------------------------------------
--	
--             The Baneguard	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Killed Undead Arkliche
-- 3 => Killed baneguard
-- 4 => Finished (returned)
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local baneIntro  = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode      = "Q3I3";
local myLocation1 = "WIGK";
local myLocation2 = "WLOB";
local myOrigin    = "CEHL";

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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3I3a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3I3_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3I3_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(200);
	QUEST_REWARD_XP(200);
	QUEST_ADD_AWARD("AICE");
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState=0;
	baneIntro=0;
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	local myTitle = GET_TEXT("[QUEST_Q3I3_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3I3_MESSAGE1]");
	
	if (idLocation==myLocation1 and questState==1) then
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
	end
end


---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation1 and questState==1) then
		return GET_TEXT("[QUEST_Q3I3_ACTION1]");
	elseif (idLocation==myLocation2 and questState==2) then
		return GET_TEXT("[QUEST_Q3I3_ACTION2]");
	elseif (idLocation==myOrigin and questState==3) then
		return GET_TEXT("[QUEST_Q3I3_ACTION3]");
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
		if(baneIntro==0) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3I3b.xml",idLocation);
			--only plays conversation once.
		else
			QUEST_BATTLE(myCode,1,1);	
		end
	elseif (questState==3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3I3c.xml",idLocation);
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
	
		local myTitle = GET_TEXT("[QUEST_Q3I3_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q3I3_SUCCESS1]");
			questState = 2;
			QUEST_COMPLETE_PART(myLocation1,1);
			QUEST_SET_VISIBILITY(myLocation2,1);
			QUEST_UPDATE_MAP();

		else
			myMessage = GET_TEXT("[QUEST_Q3I3_FAILURE1]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
			
	elseif (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q3I3_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q3I3_SUCCESS2]");
			questState = 3;
			QUEST_COMPLETE_PART(myLocation2,1);
			QUEST_UPDATE_MAP();
		else
			myMessage = GET_TEXT("[QUEST_Q3I3_FAILURE2]");
		end
		baneIntro = 1;
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
	if (questState==1) then
		return GET_TEXT("[QUEST_Q3I3_PROGRESS1]");
	elseif (questState==2) then
		return GET_TEXT("[QUEST_Q3I3_PROGRESS2]");
	elseif (questState==3) then
		return GET_TEXT("[QUEST_Q3I3_PROGRESS3]");
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

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	QUEST_BATTLE(myCode,1,1);

end

local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
	QUEST_UPDATE_MAP();
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3I3 = {
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
};





































