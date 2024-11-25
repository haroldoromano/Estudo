---------------------------------------------------------
--	
--             Reagent Hunt	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Monsters defeated, must return
-- 3 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local doneTroll = 0;
local doneWasp = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1G1";
local myLocation  = "RWHV";
local myLocation2 = "RTLH";
local myOrigin   = "CGRU";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	doneTroll = 0;
	doneWasp = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	doneTroll = 0;
	doneWasp = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1G1a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1G1_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1G1_REWARD]");
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
	QUEST_SET_RUIN_DONE(myLocation);
	QUEST_SET_RUIN_DONE(myLocation2);
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
	if (idLocation==myLocation and questState==1 and doneWasp==0) then
			return GET_TEXT("[QUEST_Q1G1_ACTION]");
	elseif (idLocation==myLocation2 and questState==1 and doneTroll==0) then
			return GET_TEXT("[QUEST_Q1G1_ACTION2]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q1G1_RETURN]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState==1 and idLocation==myLocation) then
		QUEST_BATTLE(myCode,0,1);
	elseif (questState==1 and idLocation==myLocation2) then
		QUEST_BATTLE_NOCAPTURE(myCode,1,1);
	elseif (questState==2) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1G1b.xml",myOrigin);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	local myTitle = GET_TEXT("[QUEST_Q1G1_NAME]");
	local myMessage;

	if (questState==1) then
	
		if (idLocation == myLocation) then
			if (success == 1) then
	  			doneWasp = 1;
				QUEST_SET_RUIN_DONE(myLocation);
				if(doneTroll ==1) then
					myMessage = GET_TEXT("[QUEST_Q1G1_KILL3]");
				else
					myMessage = GET_TEXT("[QUEST_Q1G1_KILL]");
				end
			else
				myMessage = GET_TEXT("[QUEST_Q1G1_FAILURE]");
			end
		elseif (idLocation == myLocation2) then
			if (success == 1) then
	  			doneTroll = 1;
				QUEST_SET_RUIN_DONE(myLocation2);
				if(doneWasp ==1) then
					myMessage = GET_TEXT("[QUEST_Q1G1_KILL3]");
				else
					myMessage = GET_TEXT("[QUEST_Q1G1_KILL2]");
				end
			else
				myMessage = GET_TEXT("[QUEST_Q1G1_FAILURE2]");
			end
		end
		if (doneTroll == 1 and doneWasp == 1) then
			QUEST_SET_RUIN_DONE(myLocation);
			QUEST_SET_RUIN_DONE(myLocation2);
			questState = 2;
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
	doneTroll = QUEST_LOAD_INT();
	doneWasp = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(doneTroll);
	QUEST_SAVE_INT(doneWasp);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q1G1_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1G1_STEP2]");
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
		return doneTroll*40 + doneWasp*40;
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
	return 2; 
end

-- CallbackConvA 				
--		(Callback fn - for end of conv)
--
local function CallbackConvA ()
	QUEST_ADD_RUIN(myLocation);
	QUEST_ADD_RUIN(myLocation2);
end

-- CallbackConvB 				
--		(Callback fn - for end of conv)
--
local function CallbackConvB ()
	-- Reward
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1G1 = {
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

















