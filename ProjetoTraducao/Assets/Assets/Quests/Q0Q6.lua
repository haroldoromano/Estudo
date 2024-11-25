---------------------------------------------------------
--	
--             None Shall Pass	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Got Quest
-- 2 => Arrived in Alfland... talked to Darkhunter
-- 3 => Killed Liche
-- 4 => Completed Quest
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
local myCode     = "Q0Q6";
local myOrigin   = "CBAR";
local myLocation = "CSIL";
local myStart    = "WALF";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q6a.xml",myOrigin);
	QUEST_SET_VISIBILITY("WALF",1);	
	QUEST_SET_VISIBILITY("CSIL",1);
	
		
	-- Add the Liche (but remove anything else there first)
	local encounterId = QUEST_ENCOUNTER_GET_AT(myLocation ,myStart);
	if (encounterId ~= "ESLI") then
		if (encounterId ~= "") then
			QUEST_ENCOUNTER_REMOVE_AT(myLocation,myStart);
		end
		QUEST_ENCOUNTER_ADD("ESLI");
	end
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0Q6_NAME]");
	local myMessage = GET_TEXT("[Q0Q6_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(350);
	QUEST_REWARD_XP(50);
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
	if (idLocation == myStart and
		QUEST_HERO_HAS_COMPANION_SELECTED("NDKH")==1 and
		questState == 1) then
			questState = 2;
			QUEST_ADD_ITEM("ILBC");
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q6b.xml",idLocation);
			QUEST_STOP_MOVEMENT();
			QUEST_UPDATE_MAP();
	elseif (idLocation == myLocation and questState == 2) then
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
	if (idLocation == myLocation) then
		return GET_TEXT("[Q0Q6_ACTION]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (QUEST_HERO_HAS_ITEM("ILBC")==1) then
		QUEST_REMOVE_ITEM("ILBC");
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q6c.xml",idLocation);
	else
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q6cc.xml",idLocation);
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
	if (questState <= 2) then
		return GET_TEXT("[Q0Q6_PROGRESS0]");
	elseif (questState == 3) then
		return GET_TEXT("[Q0Q6_PROGRESS1]");
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
		return 20;
	elseif (questState == 3) then
		return 80;
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
	return 3; 
end

-- CallbackConvX				
--		(Callback fn - for end of quest)
--
local function CallbackConvB ()
	local myTitle = GET_TEXT("[QUEST_Q0Q6_NAME]");
	local myMessage = GET_TEXT("[Q0Q6_GIFT]");
	QUEST_MESSAGE(myTitle, myMessage, myStart);
end

local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0Q6 = {
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
	CallbackConvC = CallbackConvC ,
};



























