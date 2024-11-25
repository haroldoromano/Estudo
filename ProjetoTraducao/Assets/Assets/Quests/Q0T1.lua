---------------------------------------------------------
--	
--             Practice Dummy	
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
local minLevel      = 1;
local myCode        = "Q0T1";
local myOrigin      = "CBAR";
local myPrevQuest   = "Q0T0";

---------------------------------------------------------

local function CallbackConvA ()
	questState = 1;
	QUEST_UPDATE_MAP();
	QUEST_BATTLE_CUSTOM(myCode,0,0, 
						myCode,"T1_StartTurn","T1_StartBattle","T1_Gem","","","","");
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
		QUEST_CONVERSATION("Assets\\Conversations\\Conv_Q0T1a.xml",myOrigin);
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
	local myTitle = GET_TEXT("[QUEST_Q0T1_NAME]");
	local myMessage = GET_TEXT("[QUEST_Q0T1_REWARD]");
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
			return GET_TEXT("[QUEST_Q0T1_ACTION]");
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
				TUTORIAL_OPEN("Quest_T1b");
			else
				QUEST_COMPLETE(myCode);
			end
		else
			local myTitle = GET_TEXT("[QUEST_Q0T1_NAME]");
			local myMessage = GET_TEXT("[QUEST_Q0T1_FAILURE]");
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
local tuteDoneStars			= 0;
local tuteDoneGold			= 0;
local tuteDoneGreen			= 0;
local tuteDoneRed			= 0;
local tuteDoneYellow		= 0;
local tuteDoneBlue			= 0;
local tuteDoneExtra			= 0;
local tuteDoneSpell			= 0;


local function T1_StartTurn(characterIdx, turnNo)

	-- Set up gems on first turn only
	if (turnNo == 1 and characterIdx == 0) then
		SET_DAMAGE_MULTIPLIER_ENABLED(0);
		SET_EXTRATURN_CHANCE_ENABLED(0);
		SET_WILDCARD_CHANCE_ENABLED(0);
		SET_45_PATTERN_ENABLED(0);
		SET_ILLEGAL_MOVE_DAMAGE_ENABLED(0);
		TUTORIAL_GAME_SET_GEMS("R**BO*RS","*BYOBYYR","GRGSSOS*","YGBROBR*","OOYR*BSO","*YBGRRGB","O*YGGBRY","GRSR*YBB");
	end
	
	-- Check gem layout for human player only
	if (characterIdx == 0 and turnNo >= 1) then
		
		BufferLocalGemTable();
		
		-- SKULLS...
		local keepSearching = true;
		local x1,y1,x2,y2;
		if (keepSearching and tuteDoneSkulls <= 2) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_SKULL); 
			if (x1 >= 0) then
				local msg;
				if (tuteDoneSkulls == 0) then
					msg = GET_TEXT("[OT_MATCH_SKULLS0]");
				elseif (tuteDoneSkulls == 1) then
					msg = GET_TEXT("[OT_MATCH_SKULLS1]");
				else
					msg = GET_TEXT("[OT_MATCH_SKULLS2]");
				end
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,msg,0,1);
				end
				keepSearching = false;
				tuteDoneSkulls = tuteDoneSkulls + 1;
			end
		end
		
		-- SPELLCASTING
		if (keepSearching and tuteDoneSpell<=1) then
			local spl;
			local numspl = GET_NUM_SPELLS(0);
			for spl=0,numspl-1 do
				if (IS_SPELL_CASTABLE(0,spl)) then
					local msg;
					if (tuteDoneSpell == 0) then
						msg = GET_TEXT("[OT_SPELLCASTING0]");
					elseif (tuteDoneSpell == 1) then
						msg = GET_TEXT("[OT_SPELLCASTING1]");
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
		
		-- STARS
		if (keepSearching and tuteDoneStars <= 1) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_STAR); 
			if (x1 >= 0) then
				local msg;
				if (tuteDoneStars == 0) then
					msg = GET_TEXT("[OT_MATCH_STARS0]");
				else
					msg = GET_TEXT("[OT_MATCH_STARS1]");
				end
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,msg,0,1);
				end
				keepSearching = false;
				tuteDoneStars = tuteDoneStars + 1;
			end
		end
		
		-- GOLD
		if (keepSearching and tuteDoneGold <= 1) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_GOLD); 
			if (x1 >= 0) then
				local msg;
				if (tuteDoneGold == 0) then
					msg = GET_TEXT("[OT_MATCH_GOLD0]");
				else
					msg = GET_TEXT("[OT_MATCH_GOLD1]");
				end
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,msg,0,1);
				end
				keepSearching = false;
				tuteDoneGold = tuteDoneGold + 1;
			end
		end
		
		-- GREEN MANA
		if (keepSearching and tuteDoneGreen <= 0) then
			x1,y1,x2,y2 = CheckForPatterns(GEM_GREEN); 
			if (x1 >= 0) then
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_GREEN0]"),0,1);
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
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_RED0]"),0,1);
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
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_YELLOW0]"),0,1);
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
					TUTORIAL_OPPTUTE_SWAP(x1,y1,x2,y2,GET_TEXT("[OT_MATCH_BLUE0]"),0,1);
				end
				keepSearching = false;
				tuteDoneBlue = tuteDoneBlue + 1;
			end
		end
		
		-- Extra Dialog
		if (keepSearching and tuteDoneExtra <= 0) then
				if (TUTORIAL_ACTIVE()==1) then
					TUTORIAL_OPEN("Quest_T1a");
				end
				keepSearching = false;
				tuteDoneExtra = tuteDoneExtra + 1;
		end
		
	end
	
	
	
	-- Show tute on first turn only
	if (turnNo == 1 and characterIdx == 0) then
		if (TUTORIAL_ACTIVE()==1) then
			TUTORIAL_OPEN("Quest_T1");
			if (IS_MENU_OPEN("GameMenu")) then
				TUTORIAL_GLOW_WIDGET("GameMenu","icon_enemylifepts",60,30);
			elseif (IS_MENU_OPEN("GameMenu_Wide")) then
				TUTORIAL_GLOW_WIDGET("GameMenu_Wide","icon_enemylifepts",60,30);
			end
		end
	end
	
end

local function T1_StartBattle(characterIdx)
	
end

local function T1_Gem(startGem)
	-- Types 1-7 only
	return GET_RANDOM_SYNC(1,7);
end


---------------------------------------------------------
--
--	
--		DECLARE TABLE	
--

Q0T1 = {
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
	
	T1_StartTurn = T1_StartTurn,
	T1_StartBattle = T1_StartBattle,
	T1_Gem = T1_Gem,
};















