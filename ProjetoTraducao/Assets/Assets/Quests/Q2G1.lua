---------------------------------------------------------
--	
--             Gnoll Hunters	
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
local doneTusk = 0;
local doneAlfland = 0;
local doneDhunKor = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "Q2G1";
local myLocation1    = "CTSK";
local myLocation2    = "WALF";
local myLocation3    = "CDKO";
local myOrigin      = "CHYA";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	doneTusk = 0;
	doneAlfland = 0;
	doneDhunKor = 0;

end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2G1a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2G1_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2G1_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(1000);
	QUEST_REWARD_XP(100);
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
	if (idLocation == myLocation1 and doneTusk == 0) then
		QUEST_MESSAGE(GET_TEXT("[QUEST_Q2G1_NAME]"),
				  GET_TEXT("[QUEST_Q2G1_MSG]"),
				  idLocation);

	elseif (idLocation == myLocation2 and doneAlfland == 0) then
		QUEST_MESSAGE(GET_TEXT("[QUEST_Q2G1_NAME]"),
				  GET_TEXT("[QUEST_Q2G1_MSG]"),
				  idLocation);

	elseif (idLocation == myLocation3 and doneDhunKor == 0) then
		QUEST_MESSAGE(GET_TEXT("[QUEST_Q2G1_NAME]"),
				  GET_TEXT("[QUEST_Q2G1_MSG]"),
				  idLocation);

	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation1 and questState==1 and doneTusk==0) then
			return GET_TEXT("[QUEST_Q2G1_ACTION]");
	elseif (idLocation==myLocation2 and questState==1 and doneAlfland==0) then
			return GET_TEXT("[QUEST_Q2G1_ACTION]");
	elseif (idLocation==myLocation3 and questState==1 and doneDhunKor==0) then
			return GET_TEXT("[QUEST_Q2G1_ACTION]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q2G1_RETURN]");
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2G1b.xml",idLocation);
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
	
		local myTitle = GET_TEXT("[QUEST_Q2G1_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q2G1_KILL]");
			if (idLocation == myLocation1) then
				doneTusk = 1;
			elseif (idLocation == myLocation2) then
				doneAlfland = 1;
			elseif (idLocation == myLocation3) then
				doneDhunKor = 1;
			end
			if (doneTusk ==1 and doneAlfland ==1 and doneDhunKor ==1) then
	  			questState = 2;
			end
		else
			myMessage = GET_TEXT("[QUEST_Q2G1_FAILURE]");
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
	doneTusk = QUEST_LOAD_INT();
	doneAlfland = QUEST_LOAD_INT();
	doneDhunKor = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(doneTusk );
	QUEST_SAVE_INT(doneAlfland );
	QUEST_SAVE_INT(doneDhunKor );
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q2G1_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q2G1_STEP2]");
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
		return doneTusk*25 + doneAlfland*25 + doneDhunKor*25;
	elseif (questState == 2) then
		return 75;
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

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2G1 = {
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
};








