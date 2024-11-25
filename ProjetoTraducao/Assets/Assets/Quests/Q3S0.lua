---------------------------------------------------------
--	
--            Follow The Sword	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => 'Pointed Sword' at Bane's Citadel
-- 3 => 'Pointed Sword' at the Lake of Blood
-- 4 => 'Pointed Sword' at Kal-Ungar
-- 5 => 'Pointed Sword' at the Wasteland
-- 6 => 'Pointed Sword' at the Hidden Valley
-- 7 => 'Had a drink' at the Bloodspring
-- 8 => Finished (had a drink)
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
local myCode        = "Q3S0";
local myOrigin      = "CLBC";
local myLocation1   = "WLOB";
local myLocation2   = "CKUN";
local myLocation3   = "WWAS";
local myLocation4   = "WHVA";
local myLocation5   = "WBSP";

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
	QUEST_UPDATE_MAP();
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 8;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q3S0_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q3S0_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(1000);

	QUEST_ADD_AWARD("AIMM");
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;
	QUEST_UPDATE_MAP();
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (questState == 2 and idLocation == myLocation1) then	

		if (QUEST_HERO_HAS_COMPANION_SELECTED("NSER")==1) then
			local myTitle = GET_TEXT("[QUEST_Q3S0_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q3S0_LEAVE0]");
			QUEST_MESSAGE(myTitle, myMessage, myLocation1);
			QUEST_REMOVE_COMPANION("NSER");
		end

	elseif (questState == 3 and idLocation == myLocation2) then
		

		if (QUEST_HERO_HAS_COMPANION_SELECTED("NWIN")==1) then
			local myTitle = GET_TEXT("[QUEST_Q3S0_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q3S0_LEAVE1]");
			QUEST_MESSAGE(myTitle, myMessage, myLocation2);
			QUEST_REMOVE_COMPANION("NWIN");
		end

	elseif (questState == 4 and idLocation == myLocation3) then
		

		if (QUEST_HERO_HAS_COMPANION_SELECTED("NKHA")==1) then
			local myTitle = GET_TEXT("[QUEST_Q3S0_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q3S0_LEAVE2]");
			QUEST_MESSAGE(myTitle, myMessage, myLocation3);
			QUEST_REMOVE_COMPANION("NKHA");
		end

	elseif (questState == 5 and idLocation == myLocation4) then
		

		if (QUEST_HERO_HAS_COMPANION_SELECTED("NFLI")==1) then
			local myTitle = GET_TEXT("[QUEST_Q3S0_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q3S0_LEAVE3]");
			QUEST_MESSAGE(myTitle, myMessage, myLocation4);
			QUEST_REMOVE_COMPANION("NFLI");
		end

	elseif (questState == 6 and idLocation == myLocation5) then
		

		if (QUEST_HERO_HAS_COMPANION_SELECTED("NELI")==1) then
			local myTitle = GET_TEXT("[QUEST_Q3S0_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q3S0_LEAVE4]");
			QUEST_MESSAGE(myTitle, myMessage, myLocation5);
			QUEST_REMOVE_COMPANION("NELI");
		end

	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myOrigin and questState==1) then
			return GET_TEXT("[QUEST_Q3S0_ACTION]");
	elseif (idLocation==myLocation1 and questState==2) then
			return GET_TEXT("[QUEST_Q3S0_ACTION]");
	elseif (idLocation==myLocation2 and questState==3) then
			return GET_TEXT("[QUEST_Q3S0_ACTION]");
	elseif (idLocation==myLocation3 and questState==4) then
			return GET_TEXT("[QUEST_Q3S0_ACTION]");
	elseif (idLocation==myLocation4 and questState==5) then
			return GET_TEXT("[QUEST_Q3S0_ACTION]");
	elseif (idLocation==myLocation5 and questState==6) then
			return GET_TEXT("[QUEST_Q3S0_DRINK]");
	elseif (idLocation==myOrigin and questState>1) then
			return GET_TEXT("[QUEST_Q3S0_ABANDON]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)

	local myTitle = GET_TEXT("[QUEST_Q3S0_NAME]");

	if (idLocation==myOrigin and questState==1) then
		questState = 2;
		local myMessage = GET_TEXT("[QUEST_Q3S0_SWORD0]");
		QUEST_MESSAGE_CALLBACK(myTitle, myMessage, idLocation, myCode, "CallbackMsgA");
		QUEST_SET_VISIBILITY(myLocation1,1);
	elseif (idLocation==myLocation1 and questState==2) then
		questState = 3;
		local myMessage = GET_TEXT("[QUEST_Q3S0_SWORD1]");
		QUEST_MESSAGE_CALLBACK(myTitle, myMessage, idLocation, myCode, "CallbackMsgB");
		QUEST_SET_VISIBILITY(myLocation2,1);
	elseif (idLocation==myLocation2 and questState==3) then
		questState = 4;
		local myMessage = GET_TEXT("[QUEST_Q3S0_SWORD2]");
		QUEST_MESSAGE_CALLBACK(myTitle, myMessage, idLocation, myCode, "CallbackMsgC");
		QUEST_SET_VISIBILITY(myLocation3,1);
	elseif (idLocation==myLocation3 and questState==4) then
		questState = 5;
		local myMessage = GET_TEXT("[QUEST_Q3S0_SWORD3]");
		QUEST_MESSAGE_CALLBACK(myTitle, myMessage, idLocation, myCode, "CallbackMsgD");
		QUEST_SET_VISIBILITY(myLocation4,1);
	elseif (idLocation==myLocation4 and questState==5) then
		questState = 6;
		local myMessage = GET_TEXT("[QUEST_Q3S0_SWORD4]");
		QUEST_MESSAGE_CALLBACK(myTitle, myMessage, idLocation, myCode, "CallbackMsgE");
		QUEST_SET_VISIBILITY(myLocation5,1);
	elseif (idLocation==myLocation5 and questState==6) then
		questState = 7;
		local myMessage = GET_TEXT("[QUEST_Q3S0_IMMORTAL]");
		QUEST_MESSAGE_CALLBACK(myTitle, myMessage, idLocation, myCode, "CallbackMsg");
	elseif (idLocation==myOrigin and questState>1) then
		QUEST_ABANDON(myCode);
	end
	QUEST_UPDATE_MAP();
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

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
		return GET_TEXT("[QUEST_Q3S0_STEP0]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q3S0_STEP1]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q3S0_STEP2]");
	elseif (questState == 4) then
		return GET_TEXT("[QUEST_Q3S0_STEP3]");
	elseif (questState == 5) then
		return GET_TEXT("[QUEST_Q3S0_STEP4]");
	elseif (questState == 6) then
		return GET_TEXT("[QUEST_Q3S0_STEP5]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1)*16;
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

local function CallbackMsg ()
	QUEST_COMPLETE(myCode);
end

local function CallbackMsgA ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NSER")==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3S0a.xml",myOrigin);	
		
	end
end

local function CallbackMsgB ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NWIN")==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3S0b.xml",myLocation1);	
		
	end

end

local function CallbackMsgC ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NKHA")==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3S0c.xml",myLocation2);	
		
	end

end

local function CallbackMsgD ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NFLI")==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3S0d.xml",myLocation3);	
		
	end
end

local function CallbackMsgE ()
	if (QUEST_HERO_HAS_COMPANION_SELECTED("NELI")==1) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q3S0e.xml",myLocation4);	
		
	end
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q3S0 = {
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
	
	CallbackMsg = CallbackMsg ,
	CallbackMsgA = CallbackMsgA ,
	CallbackMsgB = CallbackMsgB ,
	CallbackMsgC = CallbackMsgC ,
	CallbackMsgD = CallbackMsgD ,
	CallbackMsgE = CallbackMsgE ,
};




































