---------------------------------------------------------
--	
--             Eye of Sartek	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Talked to Queen Titania
-- 3 => Killed Monster #1
-- 4 => Killed Monster #2
-- 5 => Finished (returned)
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
local myCode     = "Q2Q3";
local myLocation = "CSIL";
local myOrigin   = "CHTP";

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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q3a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 5;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2Q3_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2Q3_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(50);
	QUEST_REWARD_XP(100);

	Std_AddEncounter("CSIL","WALF","ESEG");--Elven Guard Encounter after Eye stolen
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
		return GET_TEXT("[QUEST_Q2Q3_ACTION0]");
	elseif (idLocation==myLocation and questState==2) then
		return GET_TEXT("[QUEST_Q2Q3_ACTION1]");
	elseif (idLocation==myLocation and questState==3) then
		return GET_TEXT("[QUEST_Q2Q3_ACTION2]");
	elseif (idLocation==myOrigin and questState==4) then
		return GET_TEXT("[QUEST_Q2Q3_ACTION3]");
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q3c.xml",idLocation);
	elseif (questState==2) then
		QUEST_BATTLE(myCode,0,1);
	elseif (questState==3) then
		QUEST_BATTLE(myCode,1,1);
	elseif (questState==4) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q3b.xml",idLocation);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)
		

	if (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q2Q3_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q2Q3_SUCCESS1]");
			questState = 3;
		else
			myMessage = GET_TEXT("[QUEST_Q2Q3_FAILURE1]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
			
	elseif (questState==3) then
	
		local myTitle = GET_TEXT("[QUEST_Q2Q3_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q2Q3_SUCCESS2]");
			questState = 4;
			Std_AddEncounter("CSIL","WALF","ESEG");--Elven Guard Encounter
		else
			myMessage = GET_TEXT("[QUEST_Q2Q3_FAILURE2]");
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
	if (questState==1) then
		return GET_TEXT("[QUEST_Q2Q3_PROGRESS0]");
	elseif (questState==2) then
		return GET_TEXT("[QUEST_Q2Q3_PROGRESS1]");
	elseif (questState==3) then
		return GET_TEXT("[QUEST_Q2Q3_PROGRESS2]");
	elseif (questState==3) then
		return GET_TEXT("[QUEST_Q2Q3_PROGRESS3]");
	end
	return "";
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
	questState = 1;
	-- QUEST_ADD_RUIN(myLocation);
	QUEST_SET_VISIBILITY(myLocation); -- just in case
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	-- QUEST_SET_RUIN_DONE(myLocation);	
	QUEST_COMPLETE(myCode);
end

local function CallbackConvC ()
	questState = 2;
	QUEST_UPDATE_MAP();
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2Q3 = {
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


























