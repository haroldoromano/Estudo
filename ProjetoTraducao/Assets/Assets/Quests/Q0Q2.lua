---------------------------------------------------------
--	
--             Darkhunter	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Had the conversation witha Guard in Gallia who says -> Go to Artum
-- 3 => Been to Artum and received a message that Darkhunter is there
-- 4 => Complete
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
local myCode     = "Q0Q2";
local myLocation0= "CGAL";
local myLocation1= "WRAR";
local myOrigin   = "CBAR";


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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q2a.xml",myOrigin);
	QUEST_SET_VISIBILITY("WAPS",1);
	QUEST_SET_VISIBILITY("CGAL",1);
	QUEST_ADD_RUIN(myLocation);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0Q2_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0Q2_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(25);
	QUEST_REWARD_XP(40);
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
	if (idLocation == myLocation1 and questState == 2) then
		-- Message: You see darkhunter
		local myTitle = GET_TEXT("[QUEST_Q0Q2_NAME]");
		local myMessage = GET_TEXT("[QUEST_Q0Q2_MESSAGE]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"CallbackSeenDarkhunter");
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myLocation0 and questState==1) then
			return GET_TEXT("[QUEST_Q0Q2_SEARCH]");
	elseif (idLocation==myLocation1 and questState==2) then
			return GET_TEXT("[ON]");
	elseif (idLocation==myLocation1 and questState==3) then
			return GET_TEXT("[QUEST_Q0Q2_HELP]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (idLocation==myLocation0 and questState==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q2b.xml",idLocation);
	elseif (idLocation==myLocation1 and questState==3) then
		QUEST_BATTLE_NOCAPTURE(myCode,0,1);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==3) then
	
		local myTitle = GET_TEXT("[QUEST_Q0Q2_NAME]");
		local myMessage;
		if (success == 1) then
	  		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q2c.xml",idLocation);
		else
			myMessage = GET_TEXT("[QUEST_Q0Q2_FAIL]");
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
		return GET_TEXT("[QUEST_Q0Q2_PROG1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q0Q2_PROG2]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q0Q2_PROG3]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	if (questState==1) then
		return 0;
	elseif (questState==2) then
		return 33;
	elseif (questState==3) then
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
local function CallbackTalkedToGuard ()
	questState = 2; 
	QUEST_SET_VISIBILITY("WRAR",1);
	QUEST_UPDATE_MAP();
end

local function CallbackSeenDarkhunter ()
	questState = 3; 
	QUEST_UPDATE_MAP();
end

local function CallbackHelpedDarkhunter ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0Q2 = {
	OnInit		= OnInit,
	OnBegin		= OnBegin,
	OnEnd			= OnEnd,
	OnAbandon		= OnAbandon,
	OnEnterLocation	= OnEnterLocation,
	OnExecuteAction	= OnExecuteAction,
	OnCompleteAction	= OnCompleteAction,
	OnQueryAction	= OnQueryAction,
	OnLoad		= OnLoad,
	OnSave		= OnSave,
	OnQueryProgress	= OnQueryProgress,
	OnQueryPercentage	= OnQueryPercentage,
	OnQueryDifficulty	= OnQueryDifficulty,

	CallbackTalkedToGuard = CallbackTalkedToGuard ,
	CallbackSeenDarkhunter = CallbackSeenDarkhunter ,
	CallbackHelpedDarkhunter = CallbackHelpedDarkhunter ,
};































