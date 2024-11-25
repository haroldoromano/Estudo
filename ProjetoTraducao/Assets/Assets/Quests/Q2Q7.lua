---------------------------------------------------------
--	
--             Ribs of Sartek	
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
local done1 = 0;
local done2 = 0;
local done3 = 0;



---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "Q2Q7";
local myLocation    = "WGWK";
local myLocation1    = "WWRT";
local myLocation2    = "WSHD";
local myLocation3    = "WPIK";
local myOrigin      = "CHTP";

---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	done1 = 0;
	done2 = 0;
	done3 = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	done1 = 0;
	done2 = 0;
	done3 = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q7a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2Q7_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2Q7_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(300);
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
			return GET_TEXT("[QUEST_Q2Q7_ACTION]");
	elseif (idLocation==myLocation1 and questState==1 and done1==0) then
			return GET_TEXT("[QUEST_Q2Q7_ACTION]");
	elseif (idLocation==myLocation2 and questState==1 and done2==0) then
			return GET_TEXT("[QUEST_Q2Q7_ACTION]");
	elseif (idLocation==myLocation3 and questState==1 and done3==0) then
			return GET_TEXT("[QUEST_Q2Q7_ACTION]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q2Q7_RETURN]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	local myTitle = GET_TEXT("[QUEST_Q2Q7_NAME]");
	if (questState==1 and idLocation==myLocation) then
		QUEST_BATTLE(myCode,0,1);
	elseif (questState==1 and idLocation==myLocation1) then
		local myMessage = GET_TEXT("[QUEST_Q2Q7_NOTFOUND]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		done1 = 1;
		QUEST_UPDATE_MAP();
	elseif (questState==1 and idLocation==myLocation2) then
		local myMessage = GET_TEXT("[QUEST_Q2Q7_NOTFOUND]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		done2 = 1;
		QUEST_UPDATE_MAP();
	elseif (questState==1 and idLocation==myLocation3) then
		local myMessage = GET_TEXT("[QUEST_Q2Q7_NOTFOUND]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		done3 = 1;
		QUEST_UPDATE_MAP();
	elseif (questState==2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q7c.xml",idLocation);
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
	
		if (success == 1 and QUEST_HERO_HAS_COMPANION_SELECTED("NDRO")==1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2Q7b.xml",idLocation);
			return;
		end

		local myTitle = GET_TEXT("[QUEST_Q2Q7_NAME]");
		local myMessage;
		if (success == 1) then
	  		questState = 2;
			myMessage = GET_TEXT("[QUEST_Q2Q7_KILL]");
		else
			myMessage = GET_TEXT("[QUEST_Q2Q7_FAILURE]");
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
	done1 = QUEST_LOAD_INT();
	done2 = QUEST_LOAD_INT();
	done3 = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(done1);
	QUEST_SAVE_INT(done2);
	QUEST_SAVE_INT(done3);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q2Q7_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q2Q7_STEP2]");
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
		return done1*10 + done2*10 + done3*10;
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
	return 3; 
end

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_SET_VISIBILITY("WWRT" ,1);
	QUEST_SET_VISIBILITY("WGWK" ,1);
	Std_AddEncounter("WWRT","CTSK","EWGN");
	Std_AddEncounter("WGWK","WSHD","EGHG");
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	local myTitle = GET_TEXT("[QUEST_Q2Q7_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2Q7_KILL]");
	questState = 2;
	QUEST_MESSAGE(myTitle,myMessage,myLocation);
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2Q7 = {
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
};



















