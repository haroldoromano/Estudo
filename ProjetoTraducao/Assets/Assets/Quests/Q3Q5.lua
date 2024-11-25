---------------------------------------------------------
--	
--             Three Skulls	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Some necros slain
-- 3 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local doneNecro1 = 0;
local doneNecro2 = 0;
local doneNecro3 = 0;
local triedNecro1 = 0;
local triedNecro2 = 0;
local triedNecro3 = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "Q3Q5";
local myLocation1   = "WBBR";
local myLocation2   = "WLOB";
local myLocation3   = "WSOI";
local myOrigin      = "CYLA";

---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	doneNecro1 = 0;
	doneNecro2 = 0;
	doneNecro3 = 0;
	triedNecro1 = 0;
	triedNecro2 = 0;
	triedNecro3 = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	doneNecro1 = 0;
	doneNecro2 = 0;
	doneNecro3 = 0;
	triedNecro1 = 0;
	triedNecro2 = 0;
	triedNecro3 = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5a.xml",myOrigin);
	
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3Q5_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3Q5_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(200);
	QUEST_REWARD_XP(450);
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
	if (idLocation==myLocation1 and doneNecro1==0) then
			return GET_TEXT("[QUEST_Q3Q5_ACTION]");
	elseif (idLocation==myLocation2 and doneNecro2==0) then
			return GET_TEXT("[QUEST_Q3Q5_ACTION]");
	elseif (idLocation==myLocation3 and doneNecro3==0) then
			return GET_TEXT("[QUEST_Q3Q5_ACTION]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (idLocation==myLocation1 and doneNecro1==0) then
		if (triedNecro1 == 1) then
			QUEST_BATTLE(myCode,0,1);
		elseif (QUEST_HERO_HAS_ITEM("ISES")==0) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5b.xml",idLocation);
		else
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5bb.xml",idLocation);
		end
	elseif (idLocation==myLocation2 and doneNecro2==0) then
		if (triedNecro2 == 1) then
			QUEST_BATTLE(myCode,0,1);
		elseif (QUEST_HERO_HAS_ITEM("ISES")==0) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5c.xml",idLocation);
		else
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5cc.xml",idLocation);
		end
	elseif (idLocation==myLocation3 and doneNecro3==0) then
		if (triedNecro3 == 1) then
			QUEST_BATTLE(myCode,0,1);
		elseif (QUEST_HERO_HAS_ITEM("ISES")==0) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5d.xml",idLocation);
		else
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5dd.xml",idLocation);
		end
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)


	if (questState==1 or questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q3Q5_NAME]");
		local myMessage;

		if (success == 0) then
			myMessage = GET_TEXT("[QUEST_Q3Q5_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
			QUEST_UPDATE_MAP();
		else --  I  WON
			if (idLocation == myLocation1) then
				doneNecro1 = 1;
			elseif (idLocation == myLocation2) then
				doneNecro2 = 1;
			elseif (idLocation == myLocation3) then
				doneNecro3 = 1;
			end

			if (doneNecro1==1 and doneNecro2==1 and doneNecro3==1) then
				-- Finish
				if (QUEST_HERO_HAS_ITEM("ISES")==1 and
				    QUEST_HERO_HAS_COMPANION_SELECTED("NDKH")==1) then
					QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5e.xml",idLocation);
				elseif (QUEST_HERO_HAS_ITEM("ISES")==1) then
					QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5ff.xml",idLocation);
				else
					QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5f.xml",idLocation);
				end
			else
				-- Continue
				questState = 2;
				myMessage = GET_TEXT("[QUEST_Q3Q5_KILL]");
				QUEST_MESSAGE(myTitle,myMessage,idLocation);
				QUEST_UPDATE_MAP();
			end
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
	doneNecro1 = QUEST_LOAD_INT();
	doneNecro2 = QUEST_LOAD_INT();
	doneNecro3 = QUEST_LOAD_INT();
	triedNecro1 = QUEST_LOAD_INT();
	triedNecro2 = QUEST_LOAD_INT();
	triedNecro3 = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(doneNecro1);
	QUEST_SAVE_INT(doneNecro2);
	QUEST_SAVE_INT(doneNecro3);
	QUEST_SAVE_INT(triedNecro1);
	QUEST_SAVE_INT(triedNecro2);
	QUEST_SAVE_INT(triedNecro3);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q3Q5_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q3Q5_STEP2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState <= 2) then
		return doneNecro1*33 + doneNecro2*33 + doneNecro3*33;
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
	QUEST_SET_VISIBILITY("WTIR",1);
	QUEST_SET_VISIBILITY("WIGK",1);
	QUEST_SET_VISIBILITY("WLOB",1);
	QUEST_SET_VISIBILITY("CLBC",1);
	QUEST_SET_VISIBILITY("WSOI",1);
	QUEST_SET_VISIBILITY("WGRW",1);
	QUEST_SET_CITY_STATUS("CLBC",CITYSTATUS_CLOSED);
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	triedNecro1 = 1;
	QUEST_BATTLE(myCode,0,1);
end

local function CallbackConvC ()
	triedNecro2 = 1;
	QUEST_BATTLE(myCode,0,1);
end

local function CallbackConvD ()
	triedNecro3 = 1;
	QUEST_BATTLE(myCode,0,1);
end

local function CallbackConvE ()
	QUEST_REMOVE_COMPANION("NDKH");

	local myTitle = GET_TEXT("[QUEST_Q3Q5_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3Q5_DHLEAVE]");
	QUEST_MESSAGE_CALLBACK(myTitle,myMessage,"CLBC",myCode,"CallbackMsgE");
end

local function CallbackConvF ()
	QUEST_SET_CITY_STATUS("CLBC",CITYSTATUS_CLOSEDWITHQUESTS);
	QUEST_COMPLETE(myCode);
end

local function CallbackMsgE ()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3Q5ff.xml","CLBC");
	QUEST_UPDATE_MAP();
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3Q5 = {
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
	CallbackConvF = CallbackConvF ,
	CallbackMsgE = CallbackMsgE ,
};


























