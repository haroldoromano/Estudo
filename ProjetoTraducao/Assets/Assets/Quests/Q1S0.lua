---------------------------------------------------------
--	
--             Dwarven Heirloom	
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
local keptHeirloom = 0;
local triedToKeepKey = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1S0";
local myLocation = "ROTO";
local myOrigin   = "CDKO";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	lostToMonster = 0;
	keptHeirloom = 0;
	triedToKeepKey = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	triedToKeepKey = 0;
	lostToMonster = 0;
	keptHeirloom = 0;
	QUEST_ADD_RUIN(myLocation);
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1S0a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;

	QUEST_SET_RUIN_DONE(myLocation);
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1S0_NAME]");
	if (keptHeirloom == 1) then
		local myMessage = GET_TEXT("[QUEST_Q1S0_REWARD1]");
		QUEST_REWARD_MENU(myTitle,myMessage);
		QUEST_REWARD_ITEM("IKKE");
		QUEST_REWARD_XP(50);
	else
		local myMessage = GET_TEXT("[QUEST_Q1S0_REWARD0]");
		QUEST_REWARD_MENU(myTitle,myMessage);
		QUEST_REWARD_GOLD(200);
		QUEST_REWARD_XP(50);
		QUEST_ADD_AWARD("ADFR");
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
	if (idLocation==myLocation and questState==1) then
			return GET_TEXT("[QUEST_Q1S0_ACTION]");
	elseif (idLocation==myOrigin and questState==2) then
			return GET_TEXT("[QUEST_Q1S0_RETURN]");
	elseif (idLocation==myLocation and questState==2) then
			return GET_TEXT("[QUEST_Q1S0_KEEP]");
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

	elseif (questState==2 and idLocation == myOrigin ) then
		keptHeirloom = 0;
		QUEST_COMPLETE(myCode);

	elseif (questState==2) then

		if (QUEST_HERO_HAS_COMPANION_SELECTED("NKHA")==1 and triedToKeepKey==0) then
			triedToKeepKey = 1;
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1S0b.xml",idLocation);

		elseif (QUEST_HERO_HAS_COMPANION_SELECTED("NKHA")==1 and triedToKeepKey==1) then
			local myTitle = GET_TEXT("[QUEST_Q1S0_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q1S0_KHALKUSNO]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);

		else
			keptHeirloom = 1;
			QUEST_COMPLETE(myCode);
		end

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
	
		local myTitle = GET_TEXT("[QUEST_Q1S0_NAME]");
		local myMessage;
		if (success == 1) then
	  		questState = 2;
			myMessage = GET_TEXT("[QUEST_Q1S0_KILL]");
		else
			lostToMonster = 1;
			myMessage = GET_TEXT("[QUEST_Q1S0_FAILURE]");
		end
		QUEST_MESSAGE(myTitle,myMessage,myLocation);
		QUEST_UPDATE_MAP();
	end
end

---------------------------------------------------------
--
-- OnLoad				
--		(a save game is being loaded)
--
local function OnLoad()
	questState     = QUEST_LOAD_INT();
	lostToMonster  = QUEST_LOAD_INT();
	keptHeirloom   = QUEST_LOAD_INT();
	triedToKeepKey = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(lostToMonster);
	QUEST_SAVE_INT(keptHeirloom);
	QUEST_SAVE_INT(triedToKeepKey);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q1S0_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q1S0_STEP2]");
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
	return 2; 
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1S0 = {
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


















