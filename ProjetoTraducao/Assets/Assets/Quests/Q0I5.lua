---------------------------------------------------------
--	
--             Imperial Reply	
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
local lostToMonster = 0;
local didShrine = 0;


---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q0I5";
local myLocation = "RDPS";
local myOrigin   = "CENM";
local myEnd	     = "CBAR";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	lostToMonster = 0;
	didShrine = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	didShrine = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I5a.xml",myOrigin);
	QUEST_ADD_RUIN(myLocation);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0I5_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0I5_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(250);
	QUEST_REWARD_XP(50);

	-- Do it again in case we didn't visit on the way to the conversation
	if (didShrine == 0) then
		QUEST_SET_RUIN_DONE(myLocation);
	end
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
	QUEST_SET_RUIN_DONE(myLocation);
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
	if (idLocation==myLocation and (questState==1 or questState==2)) then
			return GET_TEXT("[QUEST_Q0I5_ACTION]");
	elseif (idLocation==myEnd and (questState==1 or questState==2)) then
			return GET_TEXT("[QUEST_Q0I5_RETURN]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if ((questState==1 or questState==2) and idLocation==myLocation ) then
		QUEST_BATTLE(myCode,0,1);
	elseif ((questState==1 or questState==2) and idLocation==myEnd) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I5b.xml",idLocation);
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
	
		local myTitle = GET_TEXT("[QUEST_Q0I5_NAME]");
		local myMessage;
		if (success == 1) then
	  		questState = 2;
			didShrine = 1;
			QUEST_SET_RUIN_DONE(myLocation);
			myMessage = GET_TEXT("[QUEST_Q0I5_KILL]");
		else
			lostToMonster = 1;
			myMessage = GET_TEXT("[QUEST_Q0I5_FAILURE]");
		end
		QUEST_MESSAGE(myTitle,myMessage,myLocation);
		
	end
end

---------------------------------------------------------
--
-- OnLoad				
--		(a save game is being loaded)
--
local function OnLoad()
	questState = QUEST_LOAD_INT();
	lostToMonster = QUEST_LOAD_INT();
	didShrine = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(lostToMonster);
	QUEST_SAVE_INT(didShrine);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q0I5_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q0I5_STEP2]");
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
		return 0;
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
	return 1; 
end


-- CallbackConvB 				
--		(Callback fn - for end of quest)
--
local function CallbackConvB ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0I5 = {
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

	CallbackConvB = CallbackConvB,
};











