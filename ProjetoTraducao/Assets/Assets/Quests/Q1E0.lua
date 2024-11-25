---------------------------------------------------------
--	
--             Beacon Fires	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Killed Monster #1 @ myLocation2
-- 3 => Killed Monster #1 @ myLocation
-- 3 => Finished (Killed Monster #2)
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
local myCode     = "Q1E0";
local myLocation = "WSGK";
local myLocation2= "WIGK";
local myOrigin   = "CEHL";


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
	QUEST_SET_VISIBILITY(myLocation,1);
	QUEST_SET_VISIBILITY(myLocation2,1);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1E0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1E0_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(300);
	QUEST_REWARD_XP(200);
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
	if (idLocation==myLocation and questState < 3) then
		return GET_TEXT("[QUEST_Q1E0_ACTION1]");
	elseif (idLocation==myLocation2 and questState ~= 2) then
		return GET_TEXT("[QUEST_Q1E0_ACTION2]");
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
	elseif (questState>1) then
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
	
		local myTitle = GET_TEXT("[QUEST_Q1E0_NAME]");
		local myMessage;
		if (success == 1) then			
			if(idLocation==myLocation) then
				questState = 3;
				myMessage = GET_TEXT("[QUEST_Q1E0_SUCCESS1]");
			else
				questState = 2;
				myMessage = GET_TEXT("[QUEST_Q1E0_SUCCESS2]");
			end
			QUEST_UPDATE_MAP();
			--QUEST_COMPLETE_PART(myCode,idLocation,1);
		else
			if(idLocation==myLocation) then
				myMessage = GET_TEXT("[QUEST_Q1E0_FAILURE1]");
			else
				myMessage = GET_TEXT("[QUEST_Q1E0_FAILURE2]");
			end
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
			
	elseif (questState>1) then
	
		local myTitle = GET_TEXT("[QUEST_Q1E0_NAME]");
		local myMessage;
		if (success == 1) then

	  		QUEST_COMPLETE(myCode);
		else
			if(idLocation==myLocation) then
				myMessage = GET_TEXT("[QUEST_Q1E0_FAILURE1]");
			else
				myMessage = GET_TEXT("[QUEST_Q1E0_FAILURE2]");
			end
			QUEST_MESSAGE(myTitle,myMessage,myLocation);
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
		return GET_TEXT("[QUEST_Q1E0_PROGRESS1]");
	elseif (questState==2) then
		return GET_TEXT("[QUEST_Q1E0_PROGRESS2]");
	elseif (questState==3) then
		return GET_TEXT("[QUEST_Q1E0_PROGRESS3]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState==1) then
		return 0
	elseif (questState>1) then
		return 50
	end
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
--
--	
--		DECLARE TABLE	
--

Q1E0 = {
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








































