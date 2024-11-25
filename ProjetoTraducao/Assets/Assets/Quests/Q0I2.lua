---------------------------------------------------------
--	
--             Imperial Message	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Nothing done yet
-- 2 => Tried to get into palace, failed
-- 3 => complete (snuck into palace)
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
local myCode     = "Q0I2";
local myOrigin   = "CBAR";
local myDestination   = "CENM";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I2a.xml",myOrigin);
	QUEST_SET_VISIBILITY("CENM",1);	
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0I2_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0I2_DONE]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(20);
	QUEST_REWARD_GOLD(100);
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
	if (idLocation == myDestination and questState == 1) then
		local myTitle = GET_TEXT("[QUEST_Q0I2_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0I2_ENMOUTH]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		QUEST_STOP_MOVEMENT();
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation == myDestination) then
		if (questState == 1) then
			return GET_TEXT("[QUEST_Q0I2_ACTION1]");
		elseif (questState == 2) then
			return GET_TEXT("[QUEST_Q0I2_ACTION2]");
		end
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState == 1) then
		-- Approach the Palace
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I2b.xml",idLocation);

	elseif (questState == 2) then
		-- Sneak into the Palace
		local myTitle = GET_TEXT("[QUEST_Q0I2_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0I2_GUARDIAN]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation, "Q0I2","CallbackGuardian");
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)
	if (success == 1 and questState == 2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I2c.xml",idLocation);
	elseif (success == 0 and questState == 2) then
		local myTitle = GET_TEXT("[QUEST_Q0I2_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0I2_FAIL]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
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
		return GET_TEXT("[QUEST_Q0I2_PROGRESS1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q0I2_PROGRESS2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState - 1)*50;
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

-- CallbackAmbush				
--		(Callback fn - for after the ambush message)
--
local function CallbackGuardian()
	  	QUEST_BATTLE(myCode,0,1);
end

-- CallbackConvB 				
--		(Callback fn - for talked to guard)
--
local function CallbackConvB () 
	questState = 2;
	QUEST_UPDATE_MAP();
end

-- CallbackConvC 				
--		(Callback fn - for end of quest)
--
local function CallbackConvC ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0I2 = {
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

	CallbackGuardian = CallbackGuardian,
	CallbackConvB = CallbackConvB ,
	CallbackConvC = CallbackConvC ,
};






















