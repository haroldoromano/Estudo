--
--	EETL
--		Description	
--

-- Local Constants
--
local myCode = "EETL";
local myLevel = 2;
local myMonster = "MLIC";


------------------------------------------------
--
-- OnQueryAppearance	
--			
--		(called when a hero moves to a new location)
--		 determines if an encounter is activated
--		 returns 1 if it appears, else 0
--
local function OnQueryAppearance()
	if (QUEST_HERO_LEVEL() >= myLevel and 
	    PERCENTILE_CHANCE() <= 2) then
			return 1;
	end
	return 0;
end

------------------------------------------------
--
-- OnQueryDisappearance	
--			
--		(called when a hero moves to a new location)
--		 determines if an encounter is DE-activated
--		 returns 1 if it disappears, else 0
--
local function OnQueryDisappearance()
	if (PERCENTILE_CHANCE() <= 1 and QUEST_COUNT_DONE("Q3Q1")>0) then
			return 1;
	end
	return 0;
end

------------------------------------------------
--
-- OnAppear		
--		
--		(called when an encounter appears)
--
local function OnAppear()
	QUEST_ENCOUNTER_ADD(myCode);
	return;
end

------------------------------------------------
--
-- OnDisappear	
--			
--		(called when an encounter disappears -
--		 ie it vanishes or is ended prematurely)
--
local function OnDisappear()
	QUEST_ENCOUNTER_REMOVE(myCode);
	return;
end

------------------------------------------------
--
-- OnComplete
--				
--		(called when an encounter is finished 
--       via a player's actions)
--		"success" = 1 if the encounter was beaten, else 0
--
local function OnComplete(success)
	if (success == 1) then
		QUEST_ENCOUNTER_REMOVE(myCode);
		QUEST_ENCOUNTER_CONTINUE();
	else
		QUEST_ENCOUNTER_TURNBACK();
	end
	return;
end

------------------------------------------------
--
-- OnExecute
--				
--		(the player is actually HAVING the encounter)
--
local function OnExecute()
	QUEST_ENCOUNTER_BATTLE(myCode,myMonster,1);
	return;
end


--	
--		DECLARE TABLE	
--

EETL = {
	OnQueryAppearance = OnQueryAppearance,
	OnQueryDisappearance = OnQueryDisappearance,
	OnAppear = OnAppear,
	OnDisappear = OnDisappear,
	OnComplete = OnComplete,
	OnExecute = OnExecute,
};



