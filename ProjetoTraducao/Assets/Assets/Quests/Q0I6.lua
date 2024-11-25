---------------------------------------------------------
--	
--             Knightly Orders	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest underway 
-- 2 => Done training - joining an order
-- 3 => Complete
-- 
---------------------------------------------------------
--
-- Local Variables
--
local questState = 0;
local beatBartonia = 0;
local beatSiria = 0;
local beatElenia = 0;
local beatTheira = 0;
local beatGildor = 0;

---------------------------------------------------------
--
-- Local Constants
--
local myCode     = "Q0I6";
local myOrigin   = "CBAR";


---------------------------------------------------------
--
-- OnInit				
--		(called for every quest when they are loading
--		 to set the initial state of all variables)
--
local function OnInit()
	questState = 0;
	beatBartonia = 0;
	beatTheira = 0;
	beatSiria = 0;
	beatGildor = 0;
	beatElenia = 0;	
end

---------------------------------------------------------
--
-- OnBegin				
--		(called when a quest is first obtained)
--
local function OnBegin()
	questState = 1;
	beatBartonia = 0;
	beatTheira = 0;
	beatSiria = 0;
	beatGildor = 0;
	beatElenia = 0;	
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 3;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0I6_NAME]");
	local myMessage = GET_TEXT("[Q0I6_DONE]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(50);
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

	if (questState==1) then
	
		if (idLocation=="CBAR" and beatBartonia==0) then
				return GET_TEXT("[Q0I6_ACTION0]");				
		elseif (idLocation=="WSIR" and beatSiria==0) then
				return GET_TEXT("[Q0I6_ACTION1]");
		elseif (idLocation=="WELE" and beatElenia==0) then
				return GET_TEXT("[Q0I6_ACTION2]");
		elseif (idLocation=="WTHR" and beatTheira==0) then
				return GET_TEXT("[Q0I6_ACTION3]");
		elseif (idLocation=="WGIL" and beatGildor==0) then
				return GET_TEXT("[Q0I6_ACTION4]");
		end
	elseif (questState==2) then
	
		if (idLocation=="CBAR") then
				return GET_TEXT("[Q0I6_JOIN0]");				
		elseif (idLocation=="WSIR") then
				return GET_TEXT("[Q0I6_JOIN1]");
		elseif (idLocation=="WELE") then
				return GET_TEXT("[Q0I6_JOIN2]");
		elseif (idLocation=="WTHR") then
				return GET_TEXT("[Q0I6_JOIN3]");
		elseif (idLocation=="WGIL") then
				return GET_TEXT("[Q0I6_JOIN4]");
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
	if (questState==1) then
	
		if (idLocation=="CBAR") then
				QUEST_BATTLE_NOCAPTURE(myCode,0,1);		
		elseif (idLocation=="WSIR") then
				QUEST_BATTLE_NOCAPTURE(myCode,1,1);
		elseif (idLocation=="WELE") then
				QUEST_BATTLE_NOCAPTURE(myCode,2,1);
		elseif (idLocation=="WTHR") then
				QUEST_BATTLE_NOCAPTURE(myCode,3,1);
		elseif (idLocation=="WGIL") then
				QUEST_BATTLE_NOCAPTURE(myCode,4,1);
		end
		
	elseif (questState==2) then
	
		if (idLocation=="CBAR") then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6aa.xml",idLocation);	
		elseif (idLocation=="WSIR") then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6bb.xml",idLocation);	
		elseif (idLocation=="WELE") then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6cc.xml",idLocation);	
		elseif (idLocation=="WTHR") then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6dd.xml",idLocation);	
		elseif (idLocation=="WGIL") then
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6ee.xml",idLocation);	
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

	local myTitle = GET_TEXT("[QUEST_Q0I6_NAME]");
	
	if (success == 0) then
	
		QUEST_MESSAGE(myTitle, GET_TEXT("[Q0I6_FAIL]"), idLocation);
		
	elseif (questState == 1) then
	
		-- Result
		if (idLocation=="CBAR") then
				beatBartonia = 1;	
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6a.xml",idLocation);	
		elseif (idLocation=="WSIR") then
				beatSiria = 1;		
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6b.xml",idLocation);	
		elseif (idLocation=="WELE") then
				beatElenia = 1;		
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6c.xml",idLocation);	
		elseif (idLocation=="WTHR") then
				beatTheira = 1;		
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6d.xml",idLocation);	
		elseif (idLocation=="WGIL") then
				beatGildor = 1;		
				QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0I6e.xml",idLocation);	
		end
		
		-- Check for completion
		if (beatBartonia == 1 and beatSiria == 1 and beatElenia == 1 and beatTheira == 1 and beatGildor == 1) then
				questState = 2;
				QUEST_MESSAGE(myTitle, GET_TEXT("[Q0I6_PROGRESS5]"), idLocation);
		else
				QUEST_MESSAGE(myTitle, GET_TEXT("[Q0I6_SUCCESS]"), idLocation);
		end
		
		QUEST_UPDATE_MAP();
		
	end

end

---------------------------------------------------------
--
-- OnLoad				
--		(a save game is being loaded)
--
local function OnLoad()
	questState	 = QUEST_LOAD_INT();
	beatBartonia = QUEST_LOAD_INT();
	beatSiria	 = QUEST_LOAD_INT();
	beatElenia	 = QUEST_LOAD_INT();
	beatTheira	 = QUEST_LOAD_INT();
	beatGildor	 = QUEST_LOAD_INT();
	
	if (beatBartonia == 1 and beatSiria == 1 and beatElenia == 1 and 
	    beatTheira == 1 and beatGildor == 1 and questState == 1) then
			questState = 2;
	end
end

---------------------------------------------------------
--
-- OnSave				
--		(a save game is being saved)
--
local function OnSave()
	QUEST_SAVE_INT(questState);
	QUEST_SAVE_INT(beatBartonia);
	QUEST_SAVE_INT(beatSiria);
	QUEST_SAVE_INT(beatElenia);
	QUEST_SAVE_INT(beatTheira);
	QUEST_SAVE_INT(beatGildor);
end

---------------------------------------------------------
--
-- OnQueryProgress		
--		(returns text describing the next step required)
--
local function OnQueryProgress()
	local myText="";
	if (questState == 1) then
		local myTotal = beatBartonia + beatTheira + beatSiria + beatGildor + beatElenia;
		if (myTotal == 0) then
			myText = GET_TEXT("[Q0I6_PROGRESS0]");
		elseif (myTotal == 1) then
			myText = GET_TEXT("[Q0I6_PROGRESS1]");
		elseif (myTotal == 2) then
			myText = GET_TEXT("[Q0I6_PROGRESS2]");
		elseif (myTotal == 3) then
			myText = GET_TEXT("[Q0I6_PROGRESS3]");
		elseif (myTotal == 4) then
			myText = GET_TEXT("[Q0I6_PROGRESS4]");
		elseif (myTotal == 5) then
			myText = GET_TEXT("[Q0I6_PROGRESS5]");
		end
	elseif (questState == 2) then
		myText = GET_TEXT("[Q0I6_PROGRESS5]");
	end
	return myText;
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()

	local amt = 0;
	
	if (questState == 1) then
		if (beatBartonia ==1) then
			amt = amt + 19;
		end
		if (beatTheira ==1) then
			amt = amt + 19;
		end
		if (beatSiria ==1) then
			amt = amt + 19;
		end
		if (beatGildor ==1) then
			amt = amt + 19;
		end
		if (beatElenia ==1) then
			amt = amt + 19;
		end
	elseif (questState == 2) then
		amt = 95;
	elseif (questState == 3) then
		amt = 100;
	end
	return amt;
end

---------------------------------------------------------
--
-- OnQueryDifficulty	
--		(returns 0-4 for difficulty - v.easy to v.difficult )
--
local function OnQueryDifficulty()
	-- average
	return 3; 
end


---------------------------------------------------------
--
-- CALLBACKS
--
local function CallbackJoinedBartonia()
	QUEST_ADD_AWARD("AKBA");
	QUEST_MESSAGE_CALLBACK(GET_TEXT("[QUEST_Q0I6_NAME]"),GET_TEXT("[Q0I6_AWARD_MESG0]"),myOrigin, myCode,"CallbackComplete");
end

local function CallbackJoinedSiria()
	QUEST_ADD_AWARD("AKSI");
	QUEST_MESSAGE_CALLBACK(GET_TEXT("[QUEST_Q0I6_NAME]"),GET_TEXT("[Q0I6_AWARD_MESG1]"),myOrigin, myCode,"CallbackComplete");
end

local function CallbackJoinedElenia()
	QUEST_ADD_AWARD("AKEL");
	QUEST_MESSAGE_CALLBACK(GET_TEXT("[QUEST_Q0I6_NAME]"),GET_TEXT("[Q0I6_AWARD_MESG2]"),myOrigin, myCode,"CallbackComplete");
end

local function CallbackJoinedTheira()
	QUEST_ADD_AWARD("AKTH");
	QUEST_MESSAGE_CALLBACK(GET_TEXT("[QUEST_Q0I6_NAME]"),GET_TEXT("[Q0I6_AWARD_MESG3]"),myOrigin, myCode,"CallbackComplete");
end

local function CallbackJoinedGildor()
	QUEST_ADD_AWARD("AKGI");
	QUEST_MESSAGE_CALLBACK(GET_TEXT("[QUEST_Q0I6_NAME]"),GET_TEXT("[Q0I6_AWARD_MESG4]"),myOrigin, myCode,"CallbackComplete");
end

local function CallbackComplete()
	QUEST_COMPLETE(myCode);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0I6 = {
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

	CallbackJoinedBartonia	= CallbackJoinedBartonia,
	CallbackJoinedSiria		= CallbackJoinedSiria,
	CallbackJoinedElenia	= CallbackJoinedElenia,
	CallbackJoinedTheira	= CallbackJoinedTheira,
	CallbackJoinedGildor	= CallbackJoinedGildor,
	CallbackComplete		= CallbackComplete,

};
















