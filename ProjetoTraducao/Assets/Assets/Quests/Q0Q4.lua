---------------------------------------------------------
--	
--             The Prisoner	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Got the Quest, haven't reached Maethelburg yet
-- 2 => Reached Maethelburg, haven't had the conversation with Moarg
-- 3 => Reached Maethelburg, HAVE had the conversation with Moarg
-- 4 => Finished in Maethelburg/Skellheim (either turned him in or let him go).
-- 5 => Done! Returned to Gallia
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local releasedMoarg = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q0Q4";
local myOrigin   = "CGAL";
local myDestination   = "WMAE";
local myDestination2   = "WSKE";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	releasedMoarg = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q4a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	if (IS_DEMO()) then
		myTitle = GET_TEXT("[QUEST_Q0Q4_END_HDR]");
		myMessage = GET_TEXT("[QUEST_Q0Q4_END_DEMO]");
		QUEST_MESSAGE(myTitle, myMessage, "CBAR");
	end
	
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;
	releasedMoarg = 0;
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (idLocation == myDestination and questState == 1) then
		local myTitle = GET_TEXT("[QUEST_Q0Q4_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0Q4_MAETHELBURG]");
		QUEST_MESSAGE_CALLBACK(myTitle, myMessage, idLocation, myCode, "CallbackEnterMaethelburg");
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation == myDestination and questState <= 3) then
		return GET_TEXT("[QUEST_Q0Q4_ACTION0]");
	elseif (idLocation == myDestination2 and questState == 3) then
		return GET_TEXT("[QUEST_Q0Q4_ACTION2]");
	elseif (idLocation == myOrigin and questState == 4) then
		return GET_TEXT("[QUEST_Q0Q4_ACTION1]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (idLocation == myDestination and questState == 2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q4c.xml",idLocation);
	elseif (idLocation == myDestination and questState == 3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q4d.xml",idLocation);
	elseif (idLocation == myDestination2 and questState == 3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q4e.xml",idLocation);
	elseif (idLocation == myOrigin and questState == 4) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q4f.xml",idLocation);
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
	releasedMoarg = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(releasedMoarg);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 2) then
		return GET_TEXT("[QUEST_Q0Q4_PROGRESS0]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q0Q4_PROGRESS1]");
	elseif (questState == 4) then
		return GET_TEXT("[QUEST_Q0Q4_PROGRESS2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*25;
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
--	Callbacks	
--
local function CallbackConvA ()
	questState = 1;
	QUEST_SET_VISIBILITY("WMAE",1);

	-- Add an encounter
	local encounterId = QUEST_ENCOUNTER_GET_AT(myDestination,myOrigin);		
	if (encounterId == "") then
		QUEST_ENCOUNTER_ADD("EMRA");
	end
end
local function CallbackEnterMaethelburg()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q4b.xml",myDestination);
end
local function CallbackConvB ()
	questState = 2;
	QUEST_UPDATE_MAP();
end
local function CallbackConvC ()
	questState = 3;
	QUEST_UPDATE_MAP();
end
local function CallbackConvD ()
	questState = 4;
	releasedMoarg = 0;
	QUEST_UPDATE_MAP();
end
local function CallbackConvE ()
	questState = 4;
	releasedMoarg = 1;

	QUEST_ADD_ITEM("ISES");
	local myTitle = GET_TEXT("[QUEST_Q0Q4_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0Q4_SWORD]");
	QUEST_MESSAGE(myTitle, myMessage, myDestination2);

	QUEST_UPDATE_MAP();
end
local function CallbackConvF ()
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0Q4_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0Q4_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(50);

	myTitle = GET_TEXT("[QUEST_Q0Q4_NAME]");
	myMessage = GET_TEXT("[QUEST_Q0Q4_COMPANION]");
	QUEST_MESSAGE_CALLBACK(myTitle, myMessage, myOrigin, myCode, "CallbackCompanion");
end

local function CallbackCompanion ()
	QUEST_ADD_COMPANION("NDKH");
	QUEST_COMPANION_MESSAGE("NDKH");

	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0Q4 = {
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
	CallbackEnterMaethelburg = CallbackEnterMaethelburg,
	CallbackConvB = CallbackConvB ,
	CallbackConvC = CallbackConvC ,
	CallbackConvD  = CallbackConvD ,
	CallbackConvE  = CallbackConvE ,
	CallbackConvF  = CallbackConvF ,

	CallbackCompanion = CallbackCompanion,
};


































