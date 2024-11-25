---------------------------------------------------------
--	
--             The Marriage	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Nothing done yet
-- 2 => Got Serephine... traveling
-- 3 => Serephine has begged in Trarg
-- 4 => Ended
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local serephineFreed = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q0I4";
local myOrigin   = "CENM";
local myLocation1     = "WBTH";
local myLocation2     = "WELE";
local myDestination   = "CTRA";


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

	QUEST_SET_VISIBILITY(myDestination,1);	

	-- Add the Wolf encounters 
	local encounterId1 = QUEST_ENCOUNTER_GET_AT(myLocation1,myDestination);
	local encounterId2 = QUEST_ENCOUNTER_GET_AT(myLocation2,myDestination);	
	
	-- Add the encounter  (but remove anything else there first)
	if (encounterId1 ~= "ETWF") then
		if (encounterId ~= "") then
			QUEST_ENCOUNTER_REMOVE_AT(myLocation1,myDestination);
		end
		QUEST_ENCOUNTER_ADD("ETWF");
	end
	if (encounterId2 ~= "EEWF") then
		if (encounterId ~= "") then
			QUEST_ENCOUNTER_REMOVE_AT(myLocation2,myDestination);
		end
		QUEST_ENCOUNTER_ADD("EEWF");
	end

	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I4a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (idLocation==myDestination and questState==2) then
		QUEST_STOP_MOVEMENT();
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I4c.xml",idLocation);
		questState = 3;
	end
end


---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (questState == 2 or questState == 3) then
		if (idLocation == "CBAR") then
			-- Free Serephine
			return GET_TEXT("[Q0I4_ACTIONFREE]");
		elseif (idLocation == myDestination) then
			-- Give Serephine
			return GET_TEXT("[Q0I4_ACTIONGIVE]");
		end
	elseif (questState == 1 and idLocation == myLocation1) then
		return GET_TEXT("[Q0I4_GETSEREPHINE]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState == 2 or questState == 3) then
		if (idLocation == "CBAR") then
			-- Free Serephine
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I4d.xml",idLocation);
			serephineFreed = 1;
		elseif (idLocation == myDestination) then
			-- Give Serephine
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I4e.xml",idLocation);
			serephineFreed = 0;
		end
	elseif (questState == 1 and idLocation == myLocation1) then
		questState = 2;
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I4b.xml",idLocation);
		QUEST_UPDATE_MAP();
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
	serephineFreed= QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(serephineFreed);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[Q0I4_PROGRESS0]");
	end
	return GET_TEXT("[Q0I4_PROGRESS1]");
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState == 1) then
		return 0;
	end
	return 50;
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

-- CallbackConvDE 				
--		(Callback fn - for end of quest)
--
local function CallbackConvDE ()
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0I4_NAME]");
	if (serephineFreed == 1) then
		local myMessage = GET_TEXT("[Q0I4_REWARD1]");
		QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage, myCode,"CallbackCompanion");
		QUEST_REWARD_GOLD(2000);
		QUEST_REWARD_ITEM("ISRI"); -- Serephines Ring
	else
		local myMessage = GET_TEXT("[Q0I4_REWARD0]");
		QUEST_REWARD_MENU(myTitle,myMessage);
		QUEST_REWARD_GOLD(50);
		QUEST_REWARD_XP(50);
		QUEST_COMPLETE(myCode);
	end
end


local function CallbackCompanion ()
	QUEST_ADD_COMPANION("NSER");
	QUEST_COMPANION_MESSAGE("NSER");	
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0I4 = {
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

	CallbackConvDE  = CallbackConvDE ,
	CallbackCompanion = CallbackCompanion,
};

























