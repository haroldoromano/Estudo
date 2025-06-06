---------------------------------------------------------
--	
--             Beneath Gildor	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Killed Rat
-- 3 => Killed Undead Rat
-- 4 => Finished (Killed Wight)
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
local myCode     = "Q0S0";
local myLocation = "RGSE";
local myOrigin   = "CBAR";


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
	QUEST_ADD_RUIN(myLocation);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0S0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0S0_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(40);
	QUEST_REWARD_ITEM("IRKA");
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
	QUEST_SET_RUIN_DONE(myLocation);
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
		return GET_TEXT("[QUEST_Q0S0_ACTION0]");
	elseif (idLocation==myLocation and questState==2) then
		return GET_TEXT("[QUEST_Q0S0_ACTION1]");
	elseif (idLocation==myLocation and questState==3) then
		return GET_TEXT("[QUEST_Q0S0_ACTION1]");
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
		QUEST_BATTLE(myCode,1,1);
	elseif (questState==3) then
		QUEST_BATTLE_NOCAPTURE(myCode,2,1);
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
	
		local myTitle = GET_TEXT("[QUEST_Q0S0_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q0S0_SUCCESS0]");
			questState = 2;
		else
			myMessage = GET_TEXT("[QUEST_Q0S0_FAILURE0]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
			
	elseif (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q0S0_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q0S0_SUCCESS1]");
			questState = 3;
		else
			myMessage = GET_TEXT("[QUEST_Q0S0_FAILURE1]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		
	elseif (questState==3) then
	
		local myTitle = GET_TEXT("[QUEST_Q0S0_NAME]");
		local myMessage;
		if (success == 1) then
			QUEST_SET_RUIN_DONE(myLocation);
	  		QUEST_COMPLETE(myCode);
		else
			myMessage = GET_TEXT("[QUEST_Q0S0_FAILURE2]");
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
		return GET_TEXT("[QUEST_Q0S0_PROGRESS0]");
	elseif (questState==2) then
		return GET_TEXT("[QUEST_Q0S0_PROGRESS1]");
	elseif (questState==3) then
		return GET_TEXT("[QUEST_Q0S0_PROGRESS1]");
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
	return 3; 
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0S0 = {
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
};



















