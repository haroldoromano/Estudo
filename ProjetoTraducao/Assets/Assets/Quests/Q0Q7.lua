---------------------------------------------------------
--	
--             Dwarven Caravan	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Got Quest
-- 2 => Met Khalkus and talked with him
-- 3 => Saved Caravan in Theira
-- 4 => Defeated the Ogre in the Hammer Pass
-- 5 => Finished (defeated Dugog)
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
local myCode     = "Q0Q7";
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
	QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q7a.xml",myOrigin);

end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 5;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0Q7_NAME]");
	local myMessage = GET_TEXT("[Q0Q7_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_ITEM("IDCL");
	QUEST_REWARD_GOLD(1000);
end

---------------------------------------------------------
--
-- OnAbandon				
--		(called when a quest has been abandoned by the player)
--
local function OnAbandon()
	-- cannot be abandoned
end

---------------------------------------------------------
--
-- OnEnterLocation		
--		(a hero has arrived at a new location)
--
local function OnEnterLocation(idLocation)
	if (questState == 3 and idLocation=="WHPS") then
		local myTitle = GET_TEXT("[QUEST_Q0Q7_NAME]");
		local myMessage = GET_TEXT("[Q0Q7_AMBUSH]");
		QUEST_MESSAGE_CALLBACK(myTitle,myMessage,idLocation, "Q0Q7","CallbackAmbush");
		QUEST_STOP_MOVEMENT();
	elseif (questState == 4 and idLocation=="CDKO") then
		local myTitle = GET_TEXT("[QUEST_Q0Q7_NAME]");
		local myMessage = GET_TEXT("[Q0Q7_DUGOG]");
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
	end
end

---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation=="WHPS" and questState==1) then
		return GET_TEXT("[Q0Q7_ACTION0]");

	elseif (idLocation=="WTHR" and questState==2) then
		return GET_TEXT("[Q0Q7_ACTION1]");

	elseif (idLocation=="CDKO" and (questState==3 or questState==4)) then
		return GET_TEXT("[Q0Q7_ACTION2]");

	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	if (idLocation=="WHPS" and questState==1) then
		-- Talk to Khalkus
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q7b.xml",idLocation);
		questState = 2;
		QUEST_UPDATE_MAP();
	elseif (idLocation=="WTHR" and questState==2) then
		-- Fight some Undead
		QUEST_BATTLE(myCode,0,1);	
	elseif (idLocation=="CDKO" and (questState==3 or questState==4)) then
		-- Fight some Undead
		QUEST_BATTLE_NOCAPTURE(myCode,2,0);	
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
	
		local myTitle = GET_TEXT("[QUEST_Q0Q7_NAME]");

		if (success == 1) then
			local myMessage = GET_TEXT("[Q0Q7_BATTLE0]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
			questState = 3;
			QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0Q7c.xml",idLocation);

			-- Add the Ogre encounter 
			QUEST_SET_VISIBILITY("CDKO",1);
			QUEST_SET_CITY_STATUS("CDKO",CITYSTATUS_CLOSED);		
			local encounterId = QUEST_ENCOUNTER_GET_AT("WHPS","CDKO");
			if (encounterId1 ~= "EDOG") then
				if (encounterId ~= "") then
					QUEST_ENCOUNTER_REMOVE_AT("WHPS","CDKO");
				end
				QUEST_ENCOUNTER_ADD("EDOG");
			end

		else -- Failure
			local myMessage = GET_TEXT("[QUEST_Q0Q7_BATTLE0_FAIL]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
		end
	
	elseif (questState == 3 and idLocation == "WHPS") then

		-- Going towards Dhun-Kor
		local myMessage;
		if (success == 0) then
			QUEST_MOVE("WTHR");
			myMessage = GET_TEXT("[Q0Q7_LOSE3]");
		else
			questState = 4;
			myMessage = GET_TEXT("[Q0Q7_WIN3]");
		end
		QUEST_MESSAGE(myTitle,myMessage,idLocation);
		QUEST_UPDATE_MAP();

	elseif (questState >= 3 and idLocation == "CDKO") then
		-- Defeat Dugog
		if (success == 0) then
			local myTitle = GET_TEXT("[QUEST_Q0Q7_NAME]");
			local myMessage = GET_TEXT("[Q0Q7_LOSE4]");
			QUEST_MESSAGE(myTitle,myMessage,idLocation);
		else
			QUEST_SET_CITY_STATUS("CDKO",CITYSTATUS_AVAILABLE);
			QUEST_COMPLETE(myCode);
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
		return GET_TEXT("[Q0Q7_STEP1]");
	elseif (questState == 2) then
		return GET_TEXT("[Q0Q7_STEP2]");
	elseif (questState == 3 or questState == 4) then
		return GET_TEXT("[Q0Q7_STEP3]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnQueryPercentage	
--		(returns a percentage of completion)
--
local function OnQueryPercentage()
	return (questState-1) * 25;
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



-- CallbackAmbush				
--		(Callback fn - for after the ambush message)
--
local function CallbackAmbush()
	  	QUEST_BATTLE(myCode,1,1);
end


local function CallbackConvC ()
	QUEST_ADD_COMPANION("NKHA");
	QUEST_COMPANION_MESSAGE("NKHA");
end

------------------------------------------------
--
-- OnCancelAction
--
--    Called whenever a battle is cancelled
--
local function OnCancelAction(idLocation)
	if(idLocation == "WHPS") then
		QUEST_MOVE("WTHR");--Move Character back to Theira
	end
end



---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0Q7 = {
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

	CallbackAmbush = CallbackAmbush,
	CallbackConvC = CallbackConvC ,
};























































