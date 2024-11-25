---------------------------------------------------------
--	
--             Tribal Chaos	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Some Orc Lords defeated
-- 3 => All 4 Orc Lords defeated
-- 4 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local numOrcLordsDefeated = 0;
local done1 = 0;
local done2 = 0;
local done3 = 0;
local done4 = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q1Q0";
local myLocation1 = "WRMO";
local myLocation2 = "WSFA";
local myLocation3 = "WBHE";
local myLocation4 = "WWSK";
local myOrigin   = "CDKO";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	numOrcLordsDefeated = 0;
	done1 = 0;
	done2 = 0;
	done3 = 0;
	done4 = 0;
	doneKhalkusDarkhunterConv = 0;
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	numOrcLordsDefeated = 0;
	done1 = 0;
	done2 = 0;
	done3 = 0;
	done4 = 0;
	doneKhalkusDarkhunterConv = 0;
	QUEST_SET_VISIBILITY(myLocation1 ,1);
	QUEST_SET_VISIBILITY(myLocation2 ,1);
	QUEST_SET_VISIBILITY(myLocation3 ,1);
	QUEST_SET_VISIBILITY(myLocation4 ,1);
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q0a.xml",myOrigin);
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q1Q0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q1Q0_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_GOLD(450);
	QUEST_REWARD_ITEM("IDAX");
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (idLocation == "WBHE" and doneKhalkusDarkhunterConv==0 and
          QUEST_HERO_HAS_COMPANION_SELECTED("NKHA")==1 and 
	    QUEST_HERO_HAS_COMPANION_SELECTED("NDKH")==1 ) then
		doneKhalkusDarkhunterConv = 1;
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q1Q0b.xml",idLocation);
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (questState==1 or questState == 2) then
		if (idLocation==myLocation1 and done1==0) then
			return GET_TEXT("[QUEST_Q1Q0_ACTION]");
		elseif (idLocation==myLocation2 and done2==0) then
			return GET_TEXT("[QUEST_Q1Q0_ACTION]");
		elseif (idLocation==myLocation3 and done3==0) then
			return GET_TEXT("[QUEST_Q1Q0_ACTION]");
		elseif (idLocation==myLocation4 and done4==0) then
			return GET_TEXT("[QUEST_Q1Q0_ACTION]");
		end
	elseif (questState==3) then
		if (idLocation==myOrigin) then
			return GET_TEXT("[QUEST_Q1Q0_RETURN]");
		end
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (questState==1 or questState == 2) then
		QUEST_BATTLE(myCode,0,1);
	elseif (questState==3) then
		QUEST_COMPLETE(myCode);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	local myTitle = GET_TEXT("[QUEST_Q1Q0_NAME]");

	if (success == 0) then
		local myMessage = GET_TEXT("[QUEST_Q1Q0_FAILURE]");
		QUEST_MESSAGE(myTitle,myMessage,myLocation);
	elseif (questState==1 or questState == 2) then
	
		if (idLocation == myLocation1) then
			done1 = 1;
			numOrcLordsDefeated = numOrcLordsDefeated + 1;
		elseif (idLocation == myLocation2) then
			done2 = 1;
			numOrcLordsDefeated = numOrcLordsDefeated + 1;
		elseif (idLocation == myLocation3) then
			done3 = 1;
			numOrcLordsDefeated = numOrcLordsDefeated + 1;
		elseif (idLocation == myLocation4) then
			done4 = 1;
			numOrcLordsDefeated = numOrcLordsDefeated + 1;
		end

		local myMessage 
		if (numOrcLordsDefeated == 1) then
			myMessage = GET_TEXT("[QUEST_Q1Q0_STEP2]");
			questState = 2;
		elseif (numOrcLordsDefeated == 2) then
			myMessage = GET_TEXT("[QUEST_Q1Q0_STEP3]");
		elseif (numOrcLordsDefeated == 3) then
			myMessage = GET_TEXT("[QUEST_Q1Q0_STEP4]");
		elseif (numOrcLordsDefeated >= 4) then
			myMessage = GET_TEXT("[QUEST_Q1Q0_STEP5]");
			questState = 3;
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
	numOrcLordsDefeated = QUEST_LOAD_INT();
	done1 = QUEST_LOAD_INT();
	done2 = QUEST_LOAD_INT();
	done3 = QUEST_LOAD_INT();
	done4 = QUEST_LOAD_INT();
	doneKhalkusDarkhunterConv = QUEST_LOAD_INT();
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(numOrcLordsDefeated);
	QUEST_SAVE_INT(done1);
	QUEST_SAVE_INT(done2);
	QUEST_SAVE_INT(done3);
	QUEST_SAVE_INT(done4);
	QUEST_SAVE_INT(doneKhalkusDarkhunterConv);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q1Q0_STEP1]");
	elseif (questState == 2 and numOrcLordsDefeated == 1) then
		return GET_TEXT("[QUEST_Q1Q0_STEP2]");
	elseif (questState == 2 and numOrcLordsDefeated == 2) then
		return GET_TEXT("[QUEST_Q1Q0_STEP3]");
	elseif (questState == 2 and numOrcLordsDefeated == 3) then
		return GET_TEXT("[QUEST_Q1Q0_STEP4]");
	elseif (questState >= 3) then
		return GET_TEXT("[QUEST_Q1Q0_STEP5]");
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
		return numOrcLordsDefeated*20;
	elseif (questState == 3) then
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


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q1Q0 = {
	OnInit			= OnInit,
	OnBegin			= OnBegin,
	OnEnd				= OnEnd,
	OnAbandon			= OnAbandon,
	OnEnterLocation		= OnEnterLocation,
	OnExecuteAction		= OnExecuteAction,
	OnCompleteAction		= OnCompleteAction,
	OnQueryAction		= OnQueryAction,
	OnLoad			= OnLoad,
	OnSave			= OnSave,
	OnQueryProgress		= OnQueryProgress,
	OnQueryPercentage		= OnQueryPercentage,
	OnQueryDifficulty		= OnQueryDifficulty,
};
















