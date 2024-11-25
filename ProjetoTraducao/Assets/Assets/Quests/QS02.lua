---------------------------------------------------------
--	
--             Imperial Legion	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest started - Imperial guard searching for you.
-- 2 => Killed first lot of imperial guard -  second lot still out there
-- 3 => Killed second lot of imperial guard
-- 4 => Finished (returned)
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local myLocation 	= "CYLA";


---------------------------------------------------------
--
-- Local Constants
--
local myCode     	= "QS02";
local myOrigin   	= "CYLA";
local maxRandom 	= 4;



local function ConvB()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QS02b.xml",myLocation);
end

local function ConvC()
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QS02c.xml",myLocation);
end

local function Battle()
	local currBattle = questState - 1;
	QUEST_BATTLE(myCode,currBattle,1);
end

---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	math.randomseed(os.time()); --new randomseed
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_QS02a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_QS02_NAME]");
	local myMessage = GET_TEXT("[QUEST_QS02_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);	
	QUEST_REWARD_GOLD(200);
	QUEST_REWARD_XP(150);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	--randomly pop up battle with imperial guards.
	local random = math.random(1,maxRandom);
	local myTitle;
	local myMessage;
	myLocation = idLocation;
	if(random==1 and QUEST_HERO_HAS_COMPANION_SELECTED("NSER")==1) then	
		QUEST_STOP_MOVEMENT();
		myTitle = GET_TEXT("[QUEST_QS02_NAME]");
		myMessage = GET_TEXT("[QUEST_QS02_BATTLE]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,myLocation,myCode,"Battle");
	end
end


---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)

	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)
		

	if (questState==1) then
	
		local myTitle = GET_TEXT("[QUEST_QS02_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_QS02_SUCCESS1]");
			QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation,myCode,"ConvB");
		else
			myMessage = GET_TEXT("[QUEST_QS02_FAILURE1]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
		end

			
	elseif (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_QS02_NAME]");
		local myMessage;
		if (success == 1) then
			myMessage = GET_TEXT("[QUEST_QS02_SUCCESS2]");
			QUEST_MESSAGE_CALLBACK(myTitle,myMessage,myLocation,myCode,"ConvC");
		else
			myMessage = GET_TEXT("[QUEST_QS02_FAILURE1]");
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
	if (questState==1) then
		return GET_TEXT("[QUEST_QS02_PROGRESS1]");
	elseif (questState==2) then
		return GET_TEXT("[QUEST_QS02_PROGRESS2]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState - 1) * 50;
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

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()	
	questState = 2;
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	questState = 3;
	QUEST_COMPLETE(myCode);
end

------------------------------------------------
--
-- OnCancelAction
--
--    Called whenever a battle is cancelled
--
local function OnCancelAction(idLocation)
	local myTitle = GET_TEXT("[QUEST_QS02_NAME]");
	local myMessage = GET_TEXT("[QUEST_QS02_CANX]");
	QUEST_MESSAGE(myTitle,myMessage,idLocation);
end





---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

QS02 = {
	OnCancelAction = OnCancelAction,
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
	CallbackConvC = CallbackConvC,
	ConvB = ConvB,
	ConvC = ConvC,
	Battle = Battle,
};
















































