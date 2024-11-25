---------------------------------------------------------
--	
--             Wolf Pack	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Have fought the Wolf - choice to help or fight.
-- 3 => Have won second fight.
-- 4 => end
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local fightWolf  = 0; -- When set to true - cannot be changed back.

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q3W0";
local myLocation1 = "WTIR";
local myLocation2 = "WIGK";
local myOrigin   = "CYLA";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	fightWolf  = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	QUEST_SET_VISIBILITY(myLocation1, 1);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	local myMessage;
	questState = 4;
	

	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3W0_NAME]");
	if(fightWolf==1) then
		myMessage = GET_TEXT("[QUEST_Q3W0_REWARD1]");
	else
		myMessage = GET_TEXT("[QUEST_Q3W0_REWARD2]");
	end
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(200);
	if (fightWolf==1 and QUEST_HERO_HAS_ITEM("IWBC")==0) then
		QUEST_REWARD_ITEM("IWBC");
	else
		QUEST_REWARD_GOLD(200);
	end
	

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

--------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation1 and questState==1) then
			return GET_TEXT("[QUEST_Q3W0_ACTION1]");
	elseif (idLocation==myLocation1 and questState==2) then
			return GET_TEXT("[QUEST_Q3W0_ACTION2]");
	elseif (idLocation==myLocation2 and questState==2 and fightWolf==0) then
			return GET_TEXT("[QUEST_Q3W0_ACTION3]");
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
	elseif (questState==2 and idLocation==myLocation1) then
		QUEST_BATTLE(myCode,1,1);
	elseif (questState==2 and idLocation==myLocation2) then
		QUEST_BATTLE(myCode,2,1);
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
	
		local myTitle = GET_TEXT("[QUEST_Q3W0_NAME]");
		local myMessage;

		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3W0a.xml",myLocation1);
	
	
	elseif (questState==2) then	
		if (idLocation==myLocation1) then
			fightWolf = 1; --once choosing to fight - lose option to help.
			if(success==1) then
				questState = 3;
				QUEST_COMPLETE(myCode);
			else
				myMessage = GET_TEXT("[QUEST_Q3W0_FAILURE1]");
			end

		elseif (idLocation==myLocation2) then
			if(success==1) then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3W0b.xml",myLocation2);
			else
				myMessage = GET_TEXT("[QUEST_Q3W0_FAILURE2]");
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
	--fightWolf = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	--QUEST_SAVE_INT(fightWolf);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q3W0_PROGRESS1]");
	elseif (questState == 2) then
		if(fightWolf==1) then
			return GET_TEXT("[QUEST_Q3W0_PROGRESS1]");
		else
			return GET_TEXT("[QUEST_Q3W0_PROGRESS2]");
		end
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState < 2) then 
		return 0;
	elseif (questState < 3) then
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
	return 2; 
end


---------------------------------------------------------
--
--	Callbacks	
--
local function CallbackConvA()
	local myTitle = GET_TEXT("[QUEST_Q3W0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3W0_MESSAGE]");
	questState = 2;
	QUEST_SET_VISIBILITY(myLocation2, 1);--make iceguard visible
	QUEST_MESSAGE(myTitle,myMessage,myLocation1);
	QUEST_UPDATE_MAP();
end

local function CallbackConvB()
	questState = 3;
      QUEST_COMPLETE(myCode);
	QUEST_UPDATE_MAP();
end




---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3W0 = {
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





































