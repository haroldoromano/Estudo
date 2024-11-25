---------------------------------------------------------
--	
--             More Hunting	
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
local doneLoc1 = 0;
local doneLoc2 = 0;
local doneLoc3 = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1R3";
local myLocation = "RUML";
local myLocation2= "RCBL";
local myLocation3= "RMOL";
local myOrigin   = "CDRH";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	doneLoc1 = 0;
	doneLoc2 = 0;
	doneLoc3 = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	doneLoc1 = 0;
	doneLoc2 = 0;
	doneLoc3 = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1R3a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
	QUEST_SET_RUIN_DONE(myLocation);
	QUEST_SET_RUIN_DONE(myLocation2);
	QUEST_SET_RUIN_DONE(myLocation3);
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
	if (idLocation==myLocation and questState==1 and doneLoc1==0) then
			return GET_TEXT("[QUEST_Q1R3_ACTION]");
	elseif (idLocation==myLocation2 and questState==1 and doneLoc2==0) then
			return GET_TEXT("[QUEST_Q1R3_ACTION]");
	elseif (idLocation==myLocation3 and questState==1 and doneLoc3==0) then
			return GET_TEXT("[QUEST_Q1R3_ACTION]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q1R3_RETURN]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)

	local myTitle = GET_TEXT("[QUEST_Q1R3_NAME]");
	local myMessage;

	if (questState==1 and idLocation==myLocation) then
		myMessage = GET_TEXT("[QUEST_Q1R3_MSGA]");
		QUEST_MESSAGE_CALLBACK(myTitle ,myMessage ,idLocation, myCode, "CallbackMsgA");
	elseif (questState==1 and idLocation==myLocation2) then
		myMessage = GET_TEXT("[QUEST_Q1R3_MSGB]");
		QUEST_MESSAGE_CALLBACK(myTitle ,myMessage ,idLocation, myCode, "CallbackMsgB");
	elseif (questState==1 and idLocation==myLocation3) then
		myMessage = GET_TEXT("[QUEST_Q1R3_MSGC]");
		QUEST_MESSAGE_CALLBACK(myTitle ,myMessage ,idLocation, myCode, "CallbackMsgC");
	elseif (questState==2) then
		myMessage = GET_TEXT("[QUEST_Q1R3_MSGE]");
		QUEST_MESSAGE_CALLBACK(myTitle ,myMessage ,idLocation, myCode, "CallbackMsgE");
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==1 and idLocation==myLocation) then
	
		local myTitle = GET_TEXT("[QUEST_Q1R3_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q1R3_MSGD]");
			QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackMsgD");
		else
			myMessage = GET_TEXT("[QUEST_Q1R3_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
		end

	elseif (questState==2) then

		local myTitle = GET_TEXT("[QUEST_Q1R3_NAME]");
		local myMessage;
		if (success == 1) then
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1R3b.xml",myOrigin);
		else
			local myTitle = GET_TEXT("[QUEST_Q1R3_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q1R3_FAILURE]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
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
	doneLoc1 = QUEST_LOAD_INT();
	doneLoc2 = QUEST_LOAD_INT();
	doneLoc3 = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(doneLoc1);
	QUEST_SAVE_INT(doneLoc2);
	QUEST_SAVE_INT(doneLoc3);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q1R3_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1R3_STEP2]");
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
		return doneLoc1*25 + doneLoc2*25 + doneLoc3*25 ;
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
	return 1; 
end



-- Callbacks				
--		(Callback fn - for end of quest/message)
--
local function CallbackConvA ()
	QUEST_ADD_RUIN(myLocation);
	QUEST_ADD_RUIN(myLocation2);
	QUEST_ADD_RUIN(myLocation3);
	QUEST_UPDATE_MAP();
end
local function CallbackConvB ()
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1R3_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1R3_REWARD]");
	QUEST_REWARD_MENU_CALLBACK(myTitle,myMessage, myCode,"CallbackCompanion");
	QUEST_REWARD_XP(200);
end
local function CallbackMsgA ()
	QUEST_BATTLE(myCode,0,1);
end
local function CallbackMsgB ()
	doneLoc2 = 1;
	QUEST_SET_RUIN_DONE(myLocation2);	
	if (doneLoc1==1 and doneLoc2==1 and doneLoc3==1) then
		questState=2;
	end	
	QUEST_UPDATE_MAP();
end
local function CallbackMsgC ()
	doneLoc3 = 1;
	QUEST_SET_RUIN_DONE(myLocation3);	
	if (doneLoc1==1 and doneLoc2==1 and doneLoc3==1) then
		questState=2;
	end	
	QUEST_UPDATE_MAP();
end
local function CallbackMsgD ()
	doneLoc1 = 1;
	QUEST_SET_RUIN_DONE(myLocation);
	if (doneLoc1==1 and doneLoc2==1 and doneLoc3==1) then
		questState=2;
	end	
	QUEST_UPDATE_MAP();
end
local function CallbackMsgE ()
	QUEST_BATTLE(myCode,1,1);
end

local function CallbackCompanion ()
	QUEST_ADD_COMPANION("NFLI");
	QUEST_COMPANION_MESSAGE("NFLI");
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1R3 = {
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

	CallbackConvA = CallbackConvA,
	CallbackConvB = CallbackConvB,
	CallbackMsgA = CallbackMsgA,
	CallbackMsgB = CallbackMsgB,
	CallbackMsgC = CallbackMsgC,
	CallbackMsgD = CallbackMsgD,
	CallbackMsgE = CallbackMsgE,

	CallbackCompanion = CallbackCompanion,
};















