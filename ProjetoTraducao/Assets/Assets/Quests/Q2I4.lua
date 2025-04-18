---------------------------------------------------------
--	
--             Arioc Blockade	
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
local myCode     = "Q2I4";
local myLocation = "WPAR";
local myOrigin   = "CHTP";
local myEncounter= "EAHG";


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
	QUEST_SET_VISIBILITY(myLocation, 1);
	Std_AddEncounter(myOrigin,myLocation,myEncounter);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 0;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2I4_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2I4_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(200);
	QUEST_REWARD_XP(150);
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
	--if the giants are no longer occupying pass and quest started
	if (QUEST_ENCOUNTER_GET_AT(myOrigin,myLocation) == "" and questState == 1) then
		local myTitle = GET_TEXT("[QUEST_Q2I4_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q2I4_MESSAGE]");
		if(idLocation == myOrigin) then
			QUEST_STOP_MOVEMENT();
			QUEST_COMPLETE(myCode);
		else
			QUEST_COMPLETE_PART(myCode,myLocation,1);
			QUEST_STOP_MOVEMENT();
		end
	elseif (idLocation == myOrigin and questState == 2) then
		QUEST_STOP_MOVEMENT();
		QUEST_COMPLETE(myCode);
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)

	if (idLocation==myLocation and questState==1) then
			--return GET_TEXT("[QUEST_Q2I4_ACTION]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q2I4_RETURN]");
	end

	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	--if (questState==1) then
	--	QUEST_BATTLE(myCode,0,1);
	--elseif (questState==2) then
	--	QUEST_COMPLETE(myCode);
	--end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==1) then
	
		local myTitle = GET_TEXT("[QUEST_Q2I4_NAME]");
		local myMessage;
		if (success == 1 ) then
	  		questState = 2;			
			myMessage = GET_TEXT("[QUEST_Q2I4_KILL]");
			
		else
			myMessage = GET_TEXT("[QUEST_Q2I4_FAILURE]");
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
		return GET_TEXT("[QUEST_Q2I4_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q2I4_STEP2]");
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


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2I4 = {
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






































