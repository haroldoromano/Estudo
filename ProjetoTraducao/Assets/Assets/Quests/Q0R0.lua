--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet (no travel)
-- 2 => Arrived in Elenia
-- 

-- Local Variables
--
local questState = 0;


-- Local Constants
--
local myCode = "Q0R0";
local myLocation = "WELE";
local myOrigin = "CBAR";

--	
--		FUNCTIONS	
--

-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
end

-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
end

-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 0;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0R0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0R0_DONE]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(10);
	QUEST_REWARD_GOLD(20);
end

-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;  -- it can be restarted
end

-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (idLocation == myLocation and questState == 1) then
		local myTitle = GET_TEXT("[QUEST_Q0R0_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0R0_MESSAGE]");
		QUEST_COMPLETE_PART(myCode,myLocation,1);
		QUEST_STOP_MOVEMENT();
	elseif (idLocation == myOrigin and questState == 2) then
		QUEST_STOP_MOVEMENT();
		QUEST_COMPLETE(myCode);
	end
	
end

-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[ON]");
			
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[ON]");

	end
	return "";
end

-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
end

-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

		
	if (questState == 1) then
		questState = 2;
		
		local myTitle = GET_TEXT("[QUEST_Q0R0_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0R0_MESSAGE]");
		QUEST_MESSAGE(myTitle, myMessage, myLocation);
		
		-- Add the spider (but remove anything else there first)
		Std_AddEncounter(myLocation,myOrigin,"EESK");
		
	end
end

-- OnLoad				
--		(a save game is being loaded)
--
local function OnLoad()
	questState	 = QUEST_LOAD_INT();
end

-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
end

-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	local myText="";
	if (questState == 1) then
		myText = GET_TEXT("[QUEST_Q0R0_ACTION0]");
	elseif (questState == 2) then
		myText = GET_TEXT("[QUEST_Q0R0_ACTION1]");
	end
	return myText;
end

-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState == 1) then 
		return 0;
	elseif (questState == 2) then
		return 50;
	end
	return 100;
end

-- OnQueryDifficulty	
--		(returns 0-4 for difficulty - v.easy to v.difficult )
--
local function OnQueryDifficulty()
	return 1;
end




--	
--		DECLARE TABLE	
--

Q0R0 = {
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












