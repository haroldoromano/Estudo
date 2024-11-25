--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet (not arrived in Elenia)
-- 2 => Fought the thief in Elenia
-- 3 => Finished
-- 

-- Local Variables
--
local questState = 0;
local lostToThief = 0;


-- Local Constants
--
local myCode = "Q0Q0";
local myLocation = "WSIR";
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
	lostToThief = 0;
end

-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	lostToThief = 0;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q0.xml",myOrigin);
end

-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0Q0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0Q0_DONE]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(20);
	QUEST_REWARD_ITEM("ILSW"); -- Longsword
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
		local myTitle = GET_TEXT("[QUEST_Q0Q0_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0Q0_AMBUSH]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,myLocation, "Q0Q0","CallbackAmbush");
		QUEST_STOP_MOVEMENT();
	end
	
end

-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation and questState==2 and lostToThief==0) then
			return GET_TEXT("[QUEST_Q0Q0_POPUP1]");
			
	elseif (idLocation==myLocation and questState==2 and lostToThief==1) then
			return GET_TEXT("[QUEST_Q0Q0_POPUP2]");

	elseif (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q0Q0_POPUP0]");
	end
	return "";
end

-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState==2 and lostToThief==0) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q0a.xml",idLocation);
	elseif (questState==2 and lostToThief==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q0b.xml",idLocation);
	elseif (questState==1) then
		local myTitle = GET_TEXT("[QUEST_Q0Q0_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0Q0_AMBUSH]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation, "Q0Q0","CallbackAmbush");
	end
end

-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)
	if (questState==1) then
	
		local myTitle = GET_TEXT("[QUEST_Q0Q0_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_Q0Q0_ACTION1]");
			lostToThief = 0;
		else
			myMessage = GET_TEXT("[QUEST_Q0Q0_ACTION2]");
			lostToThief = 1;
		end
		questState = 2;
		QUEST_MESSAGE(myTitle,myMessage,myLocation);
		
	elseif (questState==2) then
	
		QUEST_COMPLETE(myCode);
	end
end

-- OnLoad				
--		(a save game is being loaded)
--
local function OnLoad()
	questState	 = QUEST_LOAD_INT();
	lostToThief  = QUEST_LOAD_INT();
end

-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(lostToThief);
end

-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	local myText="";
	if (questState == 1) then
		myText = GET_TEXT("[QUEST_Q0Q0_ACTION0]");
	elseif (questState == 2 and lostToThief == 0) then
		myText = GET_TEXT("[QUEST_Q0Q0_ACTION1]");
	elseif (questState == 2 and lostToThief == 0) then
		myText = GET_TEXT("[QUEST_Q0Q0_ACTION2]");
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


-- CallbackAmbush				
--		(Callback fn - for after the ambush message)
--
local function CallbackAmbush()
	  	QUEST_BATTLE(myCode,0,1);
end

-- CallbackGivenMessage				
--		(Callback fn - for after the conversation)
--
local function CallbackGivenMessage()
		QUEST_COMPLETE_PART(myCode,myLocation,1);
end



--	
--		DECLARE TABLE	
--

Q0Q0 = {
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
	
	CallbackAmbush		= CallbackAmbush,
	CallbackGivenMessage= CallbackGivenMessage,
};










