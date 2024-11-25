---------------------------------------------------------
--	
--             Crest of Sartek	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Talked to Lord Greythane
-- 3 => Defeated Lord Borik & got Crest
-- 4 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local doneDarkhunterWarning = 0;


---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "Q2Q8";
local myDHConvLoc   = "CGAL";
local myLocation    = "WMAE";
local myLocation2   = "CDRA";
local myOrigin      = "CHTP";

---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	doneDarkhunterWarning = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q8a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2Q8_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2Q8_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(400);


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
	if (idLocation == myDHConvLoc  and doneDarkhunterWarning == 0 and
	    QUEST_HERO_HAS_COMPANION_SELECTED("NDKH")==1) then

			QUEST_STOP_MOVEMENT();
			doneDarkhunterWarning = 1
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q8b.xml",idLocation);

	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q2Q8_ACTION1]");
	elseif (idLocation==myLocation2 and questState==2) then
			return GET_TEXT("[QUEST_Q2Q8_ACTION2]");
	elseif (idLocation==myOrigin and questState==3) then
			return GET_TEXT("[QUEST_Q2Q8_RETURN]");
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
		if (QUEST_HERO_HAS_COMPANION_SELECTED("NDKH")==1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q8c.xml",idLocation);
		else
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q8d.xml",idLocation);
		end
	elseif (questState==2) then
		QUEST_BATTLE_NOCAPTURE(myCode,0,1);
	elseif (questState==3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q8e.xml",idLocation);
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
	
		local myTitle = GET_TEXT("[QUEST_Q2Q8_NAME]");
		local myMessage;
		if (success == 1) then
	  		questState = 3;
			myMessage = GET_TEXT("[QUEST_Q2Q8_KILL]");

			Std_AddEncounter("CDRA","WSKE","EDKN");--Knight Encounter outside Drakenburg
		else
			myMessage = GET_TEXT("[QUEST_Q2Q8_FAILURE]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);


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
	doneDarkhunterWarning = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(doneDarkhunterWarning );
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q2Q8_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q2Q8_STEP2]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q2Q8_STEP3]");
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
	doneDarkhunterWarning = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	QUEST_UPDATE_MAP();
end

local function CallbackConvD ()
	questState = 2;
	QUEST_UPDATE_MAP();
end

local function CallbackConvE ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2Q8 = {
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
	CallbackConvD = CallbackConvD ,
	CallbackConvE = CallbackConvE ,
};




















