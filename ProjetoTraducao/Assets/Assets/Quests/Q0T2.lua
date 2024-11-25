---------------------------------------------------------
--	
--             Advanced Combat	
--	
---------------------------------------------------------
--	
--		STATES	
--
-- 0 => Inactive
-- 1 => Quest obtained, nothing done yet
-- 2 => Finished
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
local myCode        = "Q0T2";
local myOrigin      = "CBAR";
local myPrevQuest   = "Q0T1";

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
	QUEST_BATTLE_CUSTOM(myCode,0,0, 
				myCode,"T2_StartTurn","T2_StartBattle","","","","T2_Match4","T2_Match5");
end

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
	if (QUEST_COUNT_DONE(myCode)==0) then
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0T2a.xml",myOrigin);
	else
		CallbackConvA();
	end
end

---------------------------------------------------------
--
-- OnEnd				
--		(called when a quest has ended)
--
local function OnEnd()
	questState = 0;
	
	-- Reward
	local myTitle = GET_TEXT("[QUEST_Q0T2_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0T2_REWARD]");
	QUEST_REWARD_MENU(myTitle,myMessage);
	QUEST_REWARD_XP(1);
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
end


---------------------------------------------------------
--
-- OnQueryAction
--		(should anything appear on the popup menu)
--
local function OnQueryAction(idLocation)
	if (idLocation==myOrigin and questState==1) then
			return GET_TEXT("[QUEST_Q0T2_ACTION]");
	end
	return "";
end

---------------------------------------------------------
--
-- OnExecuteAction				
--		(do this whenever the player executes the next action)
--
local function OnExecuteAction(idLocation)
	CallbackConvA();
end

---------------------------------------------------------
--
-- OnCompleteAction				
--		(do this whenever the player completes his action)
--		It is called after the game has returned to the map screen
--
local function OnCompleteAction(idLocation, success)

	if (questState==1) then
	
		if (success == 1) then
			if (TUTORIAL_ACTIVE()==1) then
				TUTORIAL_OPEN("Quest_T2b");
			else
				QUEST_COMPLETE(myCode);
			end
		else
			local myTitle = GET_TEXT("[QUEST_Q0T2_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q0T2_FAILURE]");
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
	return 1; 
end


---------------------------------------------------------

--
-- Local Tutorial Constants
--
local tuteDoneSkulls		= 0;
local tuteDoneMatch4		= 0;
local tuteDoneMatch5		= 0;
local tuteDoneWildcard		= 0;
local tuteDoneRedSkull		= 0;
local tuteDoneExtra			= 0;
local tuteDoneSpell			= 0;
local tuteDoneGreen			= 0;
local tuteDoneRed			= 0;
local tuteDoneYellow		= 0;
local tuteDoneBlue			= 0;


local function T2_StartTurn(characterIdx, turnNo)

	-- Set up gems on first turn only
	if (turnNo == 1 and characterIdx == 0) then
		SET_ILLEGAL_MOVE_DAMAGE_ENABLED(0);
		TUTORIAL_GAME_SET_GEMS("ROOBO*RS","GRSR*YBB","*YBGRRGB","GRGOSOSS","YGBROBR*","OOYR*BSO","*BROGYYR","O*YGSBRY");
	end
	
	-- Check gem layout for human player only
	if (characterIdx == 0 and turnNo >= 1) then
		
		BufferLocalGemTable();
		
		-- Match 5
		local keepSearching = true;
		local x1,y1,x2,y2;
		if (keepSearching and tuteDoneMatch5 <= 100) then
				x1,y1,x2,y2 = CheckForSequences(5);
				if (x1 >= 0) then
					if (TUTORIAL_ACTIVE()==1) then
						TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_5]"),0,1);
					end
					keepSearching = false;
					tuteDoneMatch5 = tuteDoneMatch5 + 1;
				end
		end
		
		-- Match 4
		if (keepSearching and tuteDoneMatch4 <= 100) then
				x1,y1,x2,y2 = CheckForSequences(4);
				if (x1 >= 0) then
					if (TUTORIAL_ACTIVE()==1) then
						TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_4]"),0,1);
					end
					keepSearching = false;
					tuteDoneMatch4 = tuteDoneMatch4 + 1;
				end
		end
		
		-- Red Skull...
		if (keepSearching and tuteDoneRedSkull <= 1) then
				x1,y1 = CheckForRedSkull();
				if (x1 >= 0) then
					local msg;
					if (tuteDoneRedSkull==0) then
						msg = GET_TEXT("[OT_REDSKULL0]");
					else
						msg = GET_TEXT("[OT_REDSKULL1]");
					end
					if (TUTORIAL_ACTIVE()==1) then
						TUTORIAL_OPPTUTE_GEM(x1,y1,msg,0,1);
					end
					keepSearching = false;
					tuteDoneRedSkull = tuteDoneRedSkull + 1;
				end
		end
		
		-- Wildcard...
		if (keepSearching and tuteDoneWildcard <= 1) then
				x1,y1,wild = CheckForWildcard();
				if (x1 >= 0) then
					local msg;
					if (tuteDoneWildcard==0) then
						msg = GET_TEXT("[OT_WILDCARD0]");
					else
						msg = GET_TEXT("[OT_WILDCARD1]");
					end
					if (TUTORIAL_ACTIVE()==1) then
						TUTORIAL_OPPTUTE_GEM(x1,y1,msg,0,1);
					end
					keepSearching = false;
					tuteDoneWildcard = tuteDoneWildcard + 1;
				end
		end
		
		-- Skulls
		if (keepSearching and tuteDoneSkulls <= 2) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_SKULL); 
			if (x1 >= 0) then
				local msg;
				if (tuteDoneSkulls == 0) then
					msg = GET_TEXT("[OT_MATCH_SKULLS3]");
				elseif (tuteDoneSkulls == 1) then
					msg = GET_TEXT("[OT_MATCH_SKULLS4]");
				else
					msg = GET_TEXT("[OT_MATCH_SKULLS5]");
				end
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,msg,0,1);
				end
				keepSearching = false;
				tuteDoneSkulls = tuteDoneSkulls + 1;
			end
		end
		
		-- SPELLCASTING
		if (keepSearching and tuteDoneSpell<=2) then
			local spl;
			local numspl = GET_NUM_SPELLS(0);
			for spl=0,numspl-1 do
				if (IS_SPELL_CASTABLE(0,spl)) then
					local msg;
					if (tuteDoneSpell == 0) then
						msg = GET_TEXT("[OT_SPELLCASTING2]");
					elseif (tuteDoneSpell == 1) then
						msg = GET_TEXT("[OT_SPELLCASTING3]");
					else
						msg = GET_TEXT("[OT_SPELLCASTING4]");
					end
					if (TUTORIAL_ACTIVE()==1) then
						TUTORIAL_OPPTUTE_SPELL(spl,msg,0,1);
					end
					keepSearching = false;
					tuteDoneSpell = tuteDoneSpell + 1;
					break;
				end
			end
		end
		
		-- GREEN MANA
		if (keepSearching and tuteDoneGreen <= 0) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_GREEN); 
			if (x1 >= 0) then
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_GREEN1]"),0,1);
				end
				keepSearching = false;
				tuteDoneGreen = tuteDoneGreen + 1;
			end
		end
		
		-- RED MANA
		if (keepSearching and tuteDoneRed <= 0) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_RED); 
			if (x1 >= 0) then
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_RED1]"),0,1);
				end
				keepSearching = false;
				tuteDoneRed = tuteDoneRed + 1;
			end
		end
		
		-- YELLOW MANA
		if (keepSearching and tuteDoneYellow <= 0) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_YELLOW); 
			if (x1 >= 0) then
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_YELLOW1]"),0,1);
				end
				keepSearching = false;
				tuteDoneYellow = tuteDoneYellow + 1;
			end
		end
		
		-- BLUE MANA
		if (keepSearching and tuteDoneBlue <= 0) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_BLUE); 
			if (x1 >= 0) then
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_BLUE1]"),0,1);
				end
				keepSearching = false;
				tuteDoneBlue = tuteDoneBlue + 1;
			end
		end
		
		-- Extra Dialog
		if (keepSearching and tuteDoneExtra <= 0) then
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPEN("Quest_T2a");
				end
				keepSearching = false;
				tuteDoneExtra = tuteDoneExtra + 1;
		end
		
	end
	
	
	
	-- Show tute on first turn only
	if (turnNo == 1 and characterIdx == 0) then
		if (TUTORIAL_ACTIVE()==1) then
			TUTORIAL_OPEN("Quest_T2");
		end
	end
	
end

local function T2_StartBattle(characterIdx)
	
end

local function T2_Match4(characterIdx)
	if (characterIdx == 0) then
		--T2_StartTurn(characterIdx, GET_TURN());
	end
end

local function T2_Match5(characterIdx)
	if (characterIdx == 0) then
		--T2_StartTurn(characterIdx, GET_TURN());
	end
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0T2 = {
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
	
	T2_StartTurn = T2_StartTurn,
	T2_StartBattle = T2_StartBattle,
	T2_Match4 = T2_Match4,
	T2_Match5 = T2_Match5,
};












