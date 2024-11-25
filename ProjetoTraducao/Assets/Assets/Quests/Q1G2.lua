---------------------------------------------------------
--	
--             Tit for Tat	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Items traded, must return
-- 3 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local doneTheira = 0;
local doneSilvermyr = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1G2";
local myLocation  = "WTHR";
local myLocation2 = "CSIL";
local myOrigin   = "CGRU";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	doneTheira = 0;
	doneSilvermyr = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	doneTheira = 0;
	doneSilvermyr = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1G2a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1G2_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1G2_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(500);
	QUEST_REWARD_XP(50);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
	QUEST_UPDATE_MAP();
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
	if (idLocation==myLocation and questState==1 and doneTheira==0) then
			return GET_TEXT("[QUEST_Q1G2_ACTION]");
	elseif (idLocation==myLocation2 and questState==1 and doneSilvermyr==0) then
			return GET_TEXT("[QUEST_Q1G2_ACTION2]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q1G2_RETURN]");
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
		local myTitle = GET_TEXT("[QUEST_Q1G2_NAME]");
		local myMessage;
		if (idLocation == myLocation) then
			doneTheira = 1;
			if( doneSilvermyr ==1) then
				myMessage = GET_TEXT("[QUEST_Q1G2_TRADE1]");
			else
				myMessage = GET_TEXT("[QUEST_Q1G2_TRADE]");
			end
		elseif (idLocation == myLocation2) then
			doneSilvermyr = 1;
			if( doneTheira ==1) then
				myMessage = GET_TEXT("[QUEST_Q1G2_TRADE3]");
			else
				myMessage = GET_TEXT("[QUEST_Q1G2_TRADE2]");
			end
		end
		if (doneTheira == 1 and doneSilvermyr == 1) then
			questState = 2;
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		QUEST_UPDATE_MAP();
	elseif (questState==2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1G2b.xml",idLocation);
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
	doneTheira = QUEST_LOAD_INT();
	doneSilvermyr = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(doneTheira );
	QUEST_SAVE_INT(doneSilvermyr );
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q1G2_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1G2_STEP2]");
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
		return doneTheira*40 + doneSilvermyr*40;
	elseif (questState == 2) then
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
	return 1; 
end

-- CallbackConvB 				
--		(Callback fn - for end of conv)
--
local function CallbackConvB ()
	QUEST_COMPLETE(myCode);
end

---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1G2 = {
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
};
















