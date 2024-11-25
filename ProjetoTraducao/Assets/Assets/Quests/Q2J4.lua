---------------------------------------------------------
--	
--             Brotherly Love	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Giants agree, must get items
-- 3 => Monster defeated, & items obtained must return
-- 4 => Finished
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local gotBlood = 0;
local gotParchment = 0;
local gotJarl = 0;
local gotJotun = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode        = "Q2J4";
local myLocation1   = "WWRT";
local myLocation2   = "CGRU";
local myOrigin1     = "CJAK";
local myOrigin2     = "CJOK";
local myDestination = "WGWK";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	gotBlood = 0;
	gotParchment = 0;
	gotJarl = 0;
	gotJotun = 0;
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
	questState = 4;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q2J4_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q2J4_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_ITEM_WITH_TEXT("IJAH",GET_TEXT("[QUEST_Q2J4_R0]"));
	QUEST_REWARD_ITEM_WITH_TEXT("IJOH",GET_TEXT("[QUEST_Q2J4_R1]"));
	
	QUEST_ADD_ITEM("IJAC");
	QUEST_ADD_ITEM("IJOB");
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	questState = 0;
	gotBlood = 0;
	gotParchment = 0;
	gotJarl = 0;
	gotJotun = 0;
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
	if (idLocation==myOrigin1 and questState==1 and gotJarl==0) then
			return GET_TEXT("[QUEST_Q2J4_TALK1]");
	elseif (idLocation==myOrigin2 and questState==1 and gotJotun==0) then
			return GET_TEXT("[QUEST_Q2J4_TALK2]");
	elseif (idLocation==myLocation1 and questState==2 and gotBlood==0) then
			return GET_TEXT("[QUEST_Q2J4_ACTION1]");
	elseif (idLocation==myLocation2 and questState==2 and gotParchment==0) then
			return GET_TEXT("[QUEST_Q2J4_ACTION2]");
	elseif (idLocation==myDestination and questState==3) then
			return GET_TEXT("[QUEST_Q2J4_RETURN]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (idLocation==myOrigin1 and questState==1 and gotJarl==0) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2J4a.xml",idLocation);
	elseif (idLocation==myOrigin2 and questState==1 and gotJotun==0) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2J4b.xml",idLocation);
	elseif (idLocation==myLocation1 and questState==2 and gotBlood==0) then
		QUEST_BATTLE(myCode,0,1);
	elseif (idLocation==myLocation2 and questState==2 and gotParchment==0 and QUEST_GET_GOLD()<100) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2J4cc.xml",idLocation);
	elseif (idLocation==myLocation2 and questState==2 and gotParchment==0) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2J4c.xml",idLocation);
	elseif (idLocation==myDestination and questState==3) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q2J4d.xml",idLocation);
	end
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==2) then
	
		local myTitle = GET_TEXT("[QUEST_Q2J4_NAME]");
		local myMessage;
		if (success == 1) then
			gotBlood = 1;
	  		if (gotParchment==1) then
				questState = 3;
			end
			myMessage = GET_TEXT("[QUEST_Q2J4_KILL]");
		else
			myMessage = GET_TEXT("[QUEST_Q2J4_FAILURE]");
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
	gotBlood = QUEST_LOAD_INT();
	gotParchment = QUEST_LOAD_INT();
	gotJarl = QUEST_LOAD_INT();
	gotJotun = QUEST_LOAD_INT();

end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(gotBlood );
	QUEST_SAVE_INT(gotParchment );
	QUEST_SAVE_INT(gotJarl );
	QUEST_SAVE_INT(gotJotun );
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	if (questState == 1) then
		return GET_TEXT("[QUEST_Q2J4_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[QUEST_Q2J4_STEP2]");
	elseif (questState == 3) then
		return GET_TEXT("[QUEST_Q2J4_STEP3]");
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
		return gotJarl*20 + gotJotun*20;
	elseif (questState == 2) then
		return 40 + gotBlood*20 + gotParchment*20;
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

local function CallbackConvA ()
	questState = 1;
	gotJarl = 1;
	if (gotJotun == 1) then
		QUEST_SET_VISIBILITY(myLocation1,1);
		questState = 2;
	end
	QUEST_UPDATE_MAP();
end

local function CallbackConvB ()
	questState = 1;
	gotJotun = 1;
	if (gotJarl == 1) then
		QUEST_SET_VISIBILITY(myLocation1,1);
		questState = 2;
	end
	QUEST_UPDATE_MAP();
end

local function CallbackConvC ()
	gotParchment = 1;
	QUEST_SPEND_GOLD(100);
	if (gotBlood ==1) then
		questState = 3;
	end
	QUEST_UPDATE_MAP();
end

local function CallbackConvD ()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q2J4 = {
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
	CallbackConvC = CallbackConvC ,
	CallbackConvD = CallbackConvD ,
};




















