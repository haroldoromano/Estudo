---------------------------------------------------------
--	
--             The Invitation	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Jarl's invitation delivered.
-- 3 => Jotus's invitation delivered.
-- 4 => both delivered
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
local myCode     = "Q2I5";
local myLocation1 = "CJAK";
local myLocation2 = "CJOK";
local giantsWalk  = "WGWK";
local blackHoof   = "WSHD";
local myOrigin   = "CTSK";


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
	QUEST_SET_VISIBILITY(blackHoof,1);
	QUEST_SET_VISIBILITY(giantsWalk,1);
	QUEST_SET_VISIBILITY(myLocation1,1);
	QUEST_SET_VISIBILITY(myLocation2,1);
	Std_AddEncounter(giantsWalk,myLocation1,"EFGI");
	Std_AddEncounter(giantsWalk,myLocation2,"EVGI");
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 5;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2I5_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2I5_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(200);
	QUEST_REWARD_XP(200);
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
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation == myLocation1 and questState~=2 and questState<4) then
		return GET_TEXT("[QUEST_Q2I5_ACTION1]");
	elseif (idLocation == myLocation2 and questState <3) then
		return GET_TEXT("[QUEST_Q2I5_ACTION2]");
	elseif (idLocation==myOrigin and questState==4) then
			return GET_TEXT("[QUEST_Q2I5_RETURN]");
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
		if (idLocation == myLocation1) then
			questState = 2;
		elseif (idLocation == myLocation2) then
			questState = 3;
		end

		QUEST_COMPLETE_PART(myCode,idLocation,1);
		
	
	elseif (questState==4) then
		QUEST_COMPLETE(myCode);
	elseif (questState >1) then
		questState = 4;
		QUEST_COMPLETE_PART(myCode,idLocation,1);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)
	local myTitle = GET_TEXT("[QUEST_Q2I5_NAME]");
	local myMessage;
	
	if (questState==2) then
		--if still one delivery to go
		myMessage = GET_TEXT("[QUEST_Q2I5_KILL1]");
	elseif(questState==3) then
		--display midway progress message.
		myMessage = GET_TEXT("[QUEST_Q2I5_KILL2]");
	else
		--display quest complete messsage.
		myMessage = GET_TEXT("[QUEST_Q2I5_KILL3]");
	end
	QUEST_MESSAGE(myTitle,myMessage,idLocation);
	QUEST_UPDATE_MAP();
		
	
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
		return GET_TEXT("[QUEST_Q2I5_STEP0]");
	elseif(questState == 2) then
		return GET_TEXT("[QUEST_Q2I5_STEP1]");
	elseif(questState == 3) then
		return GET_TEXT("[QUEST_Q2I5_STEP2]");
	elseif(questState ==4) then
		return GET_TEXT("[QUEST_Q2I5_STEP3]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState ==1) then
		return 0;
	elseif(questState < 4) then
		return 33;		
	elseif (questState == 4) then
		return 66;
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
--
--	
--		DECLARE TABLE	
--

Q2I5 = {
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
};


























