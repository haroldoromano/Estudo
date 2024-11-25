---------------------------------------------------------
--	
--             War Council	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Got quest, talked with Khrona
-- 2 => Talked to Gruulkar
-- 3 => Complete
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local foughtGuard = 0;
local talkedToKhrona = 0;
local foughtOgre = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1Q4";
local myOrigin   = "CDKO";
local myDestination1   = "CGRU";
local myDestination2   = "CGLK";
local myDestination3   = "CDKO";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	foughtGuard = 0;
	talkedToKhrona = 0;
	foughtOgre = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	foughtGuard = 0;
	talkedToKhrona = 0;
	foughtOgre = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q4a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1Q4_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1Q4_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(50);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	-- cannot abandon
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
	if (questState == 1 and idLocation == myDestination1) then
		return GET_TEXT("[QUEST_Q1Q4_ACTION0]");
	elseif (questState == 2 and idLocation == myDestination1 and foughtGuard==0) then
		return GET_TEXT("[QUEST_Q1Q4_ACTION0]");
	elseif (questState == 2 and idLocation == myDestination2 and foughtOgre==0) then
		return GET_TEXT("[QUEST_Q1Q4_ACTION1]");
	elseif (questState == 2 and idLocation == myDestination3 and talkedToKhrona==0) then
		return GET_TEXT("[QUEST_Q1Q4_ACTION2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState == 1 and idLocation == myDestination1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q4b.xml",idLocation );
	elseif (questState == 2 and idLocation == myDestination1 and foughtGuard==0) then
		QUEST_MESSAGE_CALLBACK(
				GET_TEXT("[QUEST_Q1Q4_NAME]"),
				GET_TEXT("[QUEST_Q1Q4_MSGA]"),
				idLocation, myCode, "CallbackMsgA");
	elseif (questState == 2 and idLocation == myDestination2 and foughtOgre==0) then
		QUEST_MESSAGE_CALLBACK(
				GET_TEXT("[QUEST_Q1Q4_NAME]"),
				GET_TEXT("[QUEST_Q1Q4_MSGB]"),
				idLocation, myCode, "CallbackMsgB");
	elseif (questState == 2 and idLocation == myDestination3 and talkedToKhrona==0) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q4c.xml",idLocation );
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

		if (idLocation == myDestination1) then
			if (success == 1) then
				QUEST_MESSAGE(
					GET_TEXT("[QUEST_Q1Q4_NAME]"),
					GET_TEXT("[QUEST_Q1Q4_FOUGHTGUARD1]"),
					idLocation);
				foughtGuard = 1;
			else
				QUEST_MESSAGE(
					GET_TEXT("[QUEST_Q1Q4_NAME]"),
					GET_TEXT("[QUEST_Q1Q4_FOUGHTGUARD0]"),
					idLocation);

			end
		elseif (idLocation == myDestination2) then
			if (success == 1) then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q4d.xml",idLocation );
			else
				QUEST_MESSAGE(
					GET_TEXT("[QUEST_Q1Q4_NAME]"),
					GET_TEXT("[QUEST_Q1Q4_FAILOGRE]"),
					idLocation);

			end
		end

		if (foughtGuard == 1 and foughtOgre == 1 and talkedToKhrona == 1) then
			QUEST_COMPLETE(myCode);
		else
			QUEST_UPDATE_MAP();
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
	foughtGuard = QUEST_LOAD_INT();
	foughtOgre = QUEST_LOAD_INT();
	talkedToKhrona = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState );
	QUEST_SAVE_INT(foughtGuard );
	QUEST_SAVE_INT(foughtOgre );
	QUEST_SAVE_INT(talkedToKhrona );
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q1Q4_HELP0]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1Q4_HELP1]");
	end
	return "";
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
	return foughtGuard*33 + foughtOgre *33 + talkedToKhrona *33;
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

-- Callbacks				
--		(Callback fn - for end of quest/message)
--
local function CallbackConvA ()
end
local function CallbackConvB ()
	questState = 2;
	QUEST_UPDATE_MAP();
end
local function CallbackConvC ()
	talkedToKhrona = 1;
	if (foughtGuard == 1 and foughtOgre == 1 and talkedToKhrona == 1) then
		QUEST_COMPLETE(myCode);
	else
		QUEST_UPDATE_MAP();
	end
end
local function CallbackConvD ()
	foughtOgre = 1;
	if (foughtGuard == 1 and foughtOgre == 1 and talkedToKhrona == 1) then
		QUEST_COMPLETE(myCode);
	else
		QUEST_UPDATE_MAP();
	end
end
local function CallbackMsgA ()
	QUEST_BATTLE(myCode,0,1);
end
local function CallbackMsgB ()
	QUEST_BATTLE(myCode,1,1);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1Q4 = {
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
	CallbackMsgA = CallbackMsgA ,
	CallbackMsgB = CallbackMsgB ,

};















