--
--	TUTORIALS.LUA
--		The following functions are all executed as parts of
--		the interactive game tutorials	
--

--
--	MAIN MENU
--		
--
local function OnTutorial_MainMenu(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnOpenMenu" and strdata1=="MainMenu") then
		TUTORIAL_OPEN("MainMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="MainMenu") then
		TUTORIAL_OPEN("MainMenu2");
	end
	if (eventcode == "OnCloseMenu" and strdata1=="MainMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

local function OnTutorial_MainMenu2(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnDisplayed" and strdata1=="MainMenu2") then
		if (GET_PLATFORM() == PLATFORM_XBOX360) then
			TUTORIAL_GLOW_WIDGET("MainMenu","butt_singleplayer",60,30);
			if (IS_GAMEPAD_MODE()) then
				SET_GAMEPAD_OBJECT("MainMenu","butt_singleplayer");
			end
		else
			TUTORIAL_GLOW_WIDGET("MainMenu","butt_newquest",60,30);
			if (IS_GAMEPAD_MODE()) then
				SET_GAMEPAD_OBJECT("MainMenu","butt_newquest");
			end
		end
	end
	if (eventcode == "OnCloseMenu" and strdata1=="MainMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end


--
--	CREATE HERO
--		
--
local function OnTutorial_CreateHero(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnOpenMenu" and strdata1=="CreateHeroMenu") then
		TUTORIAL_OPEN("CreateHeroMenu");
		if (IS_GAMEPAD_MODE()) then
			SET_GAMEPAD_OBJECT("TutorialMenu","gp_button_a");
		end
	end
	if (eventcode == "OnClickToContinue" and strdata1=="CreateHeroMenu") then
		TUTORIAL_CLOSE();
	end
	if (eventcode == "OnCloseMenu" and strdata1=="CreateHeroMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	SINGLE PLAYER MENU
--		
--
local function OnTutorial_SinglePlayerMenu(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnOpenMenu" and strdata1=="SinglePlayerMenu" and TUTORIAL_GET_HERO()>=0) then
		TUTORIAL_OPEN("SinglePlayerMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="SinglePlayerMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	TAVERN MENU
--		
--
local function OnTutorial_TavernMenu(eventcode,strdata1,strdata2,data1,data2)
	if ((eventcode == "OnOpenMenu" or eventcode == "Help")and strdata1=="TavernMenu") then
		TUTORIAL_OPEN("TavernMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="TavernMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	SHOP & SELL ITEMS MENU
--		
--
local function OnTutorial_ShopMenu(eventcode,strdata1,strdata2,data1,data2)
	if ((eventcode == "OnOpenMenu" or eventcode == "Help") and strdata1=="ShopMenu") then
		TUTORIAL_OPEN("ShopMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="ShopMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

local function OnTutorial_SellItemsMenu(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnButton" and strdata1=="ShopMenu" and strdata2=="butt_mode") then
		TUTORIAL_OPEN("SellItemsMenu");
	elseif (eventcode == "Help" and strdata1=="ShopMenu") then
		TUTORIAL_OPEN("SellItemsMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="SellItemsMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	INVENTORY MENU
--		
--
local function OnTutorial_InventoryIntro(eventcode,strdata1,strdata2,data1,data2)

	if (eventcode == "OnOpenMenu" and strdata1=="HeroDetailsMenu") then
		TUTORIAL_OPEN("Inv_Intro");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Intro") then
		local myMode = TUTORIAL_GET_INV_MODE();
		if (myMode==0) then         --ehdmItems
			TUTORIAL_OPEN("Inv_Items");
		elseif (myMode==1) then 	--ehdmAbilities
			TUTORIAL_OPEN("Inv_Spells");
		elseif (myMode==2) then 	--ehdmCompanions
			TUTORIAL_OPEN("Inv_Companions");
		elseif (myMode==3) then 	--ehdmPets
			TUTORIAL_OPEN("Inv_Pets");
		elseif (myMode==4) then 	--ehdmMounts
			TUTORIAL_OPEN("Inv_Mounts");
		elseif (myMode==5) then 	--ehdmKingdom
			TUTORIAL_OPEN("Inv_Kingdom");
		elseif (myMode==6) then 	--ehdmRumors
			TUTORIAL_OPEN("Inv_Rumors");
		elseif (myMode==7) then 	--ehdmVictories
			TUTORIAL_OPEN("Inv_Battles");
		elseif (myMode==8) then 	--ehdmAwards
			TUTORIAL_OPEN("Inv_Awards");
		end
	end
	
	return;	   
end
local function OnTutorial_InventoryItems(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Items") then
		TUTORIAL_OPEN("Inv_Items");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Items") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventorySpells(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Spells") then
		TUTORIAL_OPEN("Inv_Spells");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Spells") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventoryAwards(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Awards") then
		TUTORIAL_OPEN("Inv_Awards");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Awards") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventoryMounts(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Mounts") then
		TUTORIAL_OPEN("Inv_Mounts");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Mounts") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventoryPets(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Pets") then
		TUTORIAL_OPEN("Inv_Pets");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Pets") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventoryCompanions(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Companions") then
		TUTORIAL_OPEN("Inv_Companions");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Companions") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventoryKingdom(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Kingdom") then
		TUTORIAL_OPEN("Inv_Kingdom");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Kingdom") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventoryRumors(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Rumors") then
		TUTORIAL_OPEN("Inv_Rumors");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Rumors") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_InventoryBattles(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Inventory" and strdata1=="Battles") then
		TUTORIAL_OPEN("Inv_Battles");
	elseif (eventcode == "OnClickToContinue" and strdata1=="Inv_Battles") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	INVENTORY MENU
--		
--
local function OnTutorial_YourCityMenu(eventcode,strdata1,strdata2,data1,data2)
	if ((eventcode == "OnOpenMenu" or eventcode == "Help") and strdata1=="CityMenu") then
		TUTORIAL_OPEN("YourCity_Intro");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Intro") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCityItems(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Items") then
		TUTORIAL_OPEN("YourCity_Items");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Items") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCitySpells(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Spells") then
		TUTORIAL_OPEN("YourCity_Spells");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Spells") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCityMounts(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Mounts") then
		TUTORIAL_OPEN("YourCity_Mounts");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Mounts") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCityPets(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Pets") then
		TUTORIAL_OPEN("YourCity_Pets");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Pets") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCitySkills(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Skills") then
		TUTORIAL_OPEN("YourCity_Skills");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Skills") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCityCities(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Cities") then
		TUTORIAL_OPEN("YourCity_Cities");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Cities") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCityTower(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Tower") then
		TUTORIAL_OPEN("YourCity_Tower");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Tower") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_YourCityVault(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "YourCity" and strdata1=="Vault") then
		TUTORIAL_OPEN("YourCity_Vault");
	elseif (eventcode == "OnClickToContinue" and strdata1=="YourCity_Vault") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	LEVEL UP MENU
--		
--
local function OnTutorial_LevelUpMenu(eventcode,strdata1,strdata2,data1,data2)
	if ((eventcode == "OnOpenMenu" or eventcode == "Help") and strdata1=="LevelUpMenu") then
		TUTORIAL_OPEN("LevelUpMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="LevelUpMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	CAPTURE MENU
--		
--
local function OnTutorial_CaptureMenu(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnOpenMenu" and strdata1=="CaptureMenu") then
		TUTORIAL_OPEN("CaptureMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="CaptureMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	ITEM GAME MENU
--		
--
local function OnTutorial_ItemGameMenu(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnOpenMenu" and strdata1=="ItemGameMenu") then
		TUTORIAL_OPEN("ItemGameMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="ItemGameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	SPELL GAME MENU
--		
--
local function OnTutorial_SpellGameMenu(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnOpenMenu" and strdata1=="SpellGameMenu") then
		TUTORIAL_OPEN("SpellGameMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="SpellGameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	MAP MENU
--		
--
local function OnTutorial_MapMenu(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Help" and strdata1=="MapMenu") then
		TUTORIAL_OPEN("MapMenu");
	elseif (eventcode == "Help" and strdata1=="MapMenuQuest") then
		TUTORIAL_OPEN("MapMenuQuest");
	elseif (eventcode == "Help" and strdata1=="MapMenuHero") then
		TUTORIAL_OPEN("MapMenuHero");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="MapMenu") then
		TUTORIAL_CLOSE();
	elseif (eventcode == "OnClickToContinue" and strdata1=="MapMenuQuest") then
		TUTORIAL_CLOSE();
	elseif (eventcode == "OnClickToContinue" and strdata1=="MapMenuHero") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	SELECT SPELL MENU
--		
--
local function OnTutorial_SelectSpellMenu(eventcode,strdata1,strdata2,data1,data2)
	if ((eventcode == "OnOpenMenu" or eventcode == "Help") and strdata1=="SelectSpellMenu") then
		TUTORIAL_OPEN("SelectSpellMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="SelectSpellMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	SELECT RUNE MENU
--		
--
local function OnTutorial_SelectRuneMenu(eventcode,strdata1,strdata2,data1,data2)
	if ((eventcode == "OnOpenMenu" or eventcode == "Help") and strdata1=="SelectRuneMenu") then
		TUTORIAL_OPEN("SelectRuneMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="SelectRuneMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	SELECT MOUNT MENU
--		
--
local function OnTutorial_SelectMountMenu(eventcode,strdata1,strdata2,data1,data2)
	if ((eventcode == "OnOpenMenu" or eventcode == "Help") and strdata1=="SelectMountMenu") then
		TUTORIAL_OPEN("SelectMountMenu");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="SelectMountMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	MANA DRAIN
--		
--
local function OnTutorial_ManaDrain(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Help" and strdata1=="ManaDrain") then
		TUTORIAL_OPEN("ManaDrain");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="ManaDrain") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	ILLEGAL MOVE
--		
--
local function OnTutorial_IllegalMove0(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Help" and strdata1=="IllegalMove0") then
		TUTORIAL_OPEN("IllegalMove0");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="IllegalMove0") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_IllegalMove1(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Help" and strdata1=="IllegalMove1") then
		TUTORIAL_OPEN("IllegalMove1");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="IllegalMove1") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	HEROIC EFFORT
--		
--
local function OnTutorial_HeroicEffort(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "Help" and strdata1=="HeroicEffort") then
		TUTORIAL_OPEN("HeroicEffort");
	end
	if (eventcode == "OnClickToContinue" and strdata1=="HeroicEffort") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	QUESTS 
--		
--
local function OnTutorial_QuestIntro(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnOpenMenu" and strdata1=="MapMenu") then
		if (QUEST_COUNT_DONE("Q0T0") == 0 and QUEST_IS_ACTIVE("Q0T0") == 0 and QUEST_GET_CURRENT_LOCATION()=="CBAR") then
			TUTORIAL_OPEN("QuestIntro");
		elseif (QUEST_COUNT_DONE("Q0T0") == 0 and QUEST_IS_ACTIVE("Q0T0") == 0 and QUEST_GET_CURRENT_LOCATION()~="CBAR") then
			TUTORIAL_OPEN("QuestIntro_a");
		end
	end
	if (eventcode == "OnClickToContinue" and strdata1=="QuestIntro") then
		TUTORIAL_OPEN("QuestIntro2");
	elseif (eventcode == "OnClickToContinue" and strdata1=="QuestIntro_a") then
		TUTORIAL_OPEN("QuestIntro2_a");
	end
	if (eventcode == "OnCloseMenu" and strdata1=="MapMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

local function OnTutorial_QuestIntro2(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnCloseMenu" and strdata1=="MapMenu") then
		TUTORIAL_CLOSE();
	elseif (eventcode == "OnOpenMenu" and strdata1=="GetQuestMenu") then
		TUTORIAL_CLOSE();
	elseif (eventcode == "OnClickToContinue" and strdata1=="QuestIntro2") then
		TUTORIAL_CLOSE();
	elseif (eventcode == "OnClickToContinue" and strdata1=="QuestIntro2_a") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

local function OnTutorial_QuestMove(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnCloseMenu" and strdata1=="MapMenu") then
		TUTORIAL_CLOSE();
	elseif (eventcode == "OnOpenMenu" and strdata1=="QuestMessageMenu") then
		TUTORIAL_CLOSE();
	end
	if (eventcode == "OnClickToContinue" and strdata1=="QuestMove") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

local function OnTutorial_QuestAction(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnCloseMenu" and strdata1=="MapMenu") then
		TUTORIAL_CLOSE();
	elseif (eventcode == "OnOpenMenu" and strdata1=="ConversationMenu") then
		TUTORIAL_CLOSE();
	end
	if (eventcode == "OnClickToContinue" and strdata1=="QuestAction") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

local function OnTutorial_QuestMoreQuests(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="QuestMoreQuests") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	TUTORIAL #1 
--		
--
local function OnTutorial_Quest_T1(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="Quest_T1") then
		TUTORIAL_OPEN("Quest_T1aa");
	end
	if (eventcode == "OnCloseMenu" and strdata1=="GameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_Quest_T1aa(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="Quest_T1aa") then
		TUTORIAL_CLOSE();
	end
	if (eventcode == "OnCloseMenu" and strdata1=="GameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_Quest_T1a(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="Quest_T1a") then
		TUTORIAL_CLOSE();
	end
	if (eventcode == "OnCloseMenu" and strdata1=="GameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_Quest_T1b(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="Quest_T1b") then
		TUTORIAL_CLOSE();
		QUEST_COMPLETE("Q0T1");
	end
	if (eventcode == "OnCloseMenu" and strdata1=="GameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end

--
--	TUTORIAL #2
--		
--
local function OnTutorial_Quest_T2(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="Quest_T2") then
		TUTORIAL_CLOSE();
	end
	if (eventcode == "OnCloseMenu" and strdata1=="GameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_Quest_T2a(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="Quest_T2a") then
		TUTORIAL_CLOSE();
	end
	if (eventcode == "OnCloseMenu" and strdata1=="GameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end
local function OnTutorial_Quest_T2b(eventcode,strdata1,strdata2,data1,data2)
	if (eventcode == "OnClickToContinue" and strdata1=="Quest_T2b") then
		TUTORIAL_CLOSE();
		QUEST_COMPLETE("Q0T2");
	end
	if (eventcode == "OnCloseMenu" and strdata1=="GameMenu") then
		TUTORIAL_CLOSE();
	end
	return;	   
end



--	
--		DECLARE TABLE	
--
Tutorial = {
	OnTutorial_MainMenu  = OnTutorial_MainMenu,
	OnTutorial_MainMenu2 = OnTutorial_MainMenu2,
	OnTutorial_CreateHero = OnTutorial_CreateHero,
	OnTutorial_SinglePlayerMenu = OnTutorial_SinglePlayerMenu,
	OnTutorial_TavernMenu = OnTutorial_TavernMenu,
	OnTutorial_ShopMenu = OnTutorial_ShopMenu,
	OnTutorial_SellItemsMenu = OnTutorial_SellItemsMenu,
	OnTutorial_InventoryIntro = OnTutorial_InventoryIntro,
	OnTutorial_InventoryItems = OnTutorial_InventoryItems,
	OnTutorial_InventorySpells = OnTutorial_InventorySpells,
	OnTutorial_InventoryRumors = OnTutorial_InventoryRumors,
	OnTutorial_InventoryPets = OnTutorial_InventoryPets,
	OnTutorial_InventoryMounts = OnTutorial_InventoryMounts,
	OnTutorial_InventoryCompanions = OnTutorial_InventoryCompanions,
	OnTutorial_InventoryKingdom = OnTutorial_InventoryKingdom,
	OnTutorial_InventoryBattles = OnTutorial_InventoryBattles,
	OnTutorial_InventoryAwards = OnTutorial_InventoryAwards,
	OnTutorial_YourCityMenu = OnTutorial_YourCityMenu,
	OnTutorial_YourCityItems = OnTutorial_YourCityItems,
	OnTutorial_YourCitySpells = OnTutorial_YourCitySpells,
	OnTutorial_YourCityPets = OnTutorial_YourCityPets,
	OnTutorial_YourCityCities = OnTutorial_YourCityCities,
	OnTutorial_YourCityMounts = OnTutorial_YourCityMounts,
	OnTutorial_YourCitySkills = OnTutorial_YourCitySkills,
	OnTutorial_YourCityTower = OnTutorial_YourCityTower,
	OnTutorial_YourCityVault = OnTutorial_YourCityVault,
	OnTutorial_LevelUpMenu = OnTutorial_LevelUpMenu,
	OnTutorial_CaptureMenu = OnTutorial_CaptureMenu,
	OnTutorial_ItemGameMenu = OnTutorial_ItemGameMenu,
	OnTutorial_SpellGameMenu = OnTutorial_SpellGameMenu,
	OnTutorial_MapMenu = OnTutorial_MapMenu,
	OnTutorial_SelectSpellMenu = OnTutorial_SelectSpellMenu,
	OnTutorial_SelectRuneMenu = OnTutorial_SelectRuneMenu,
	OnTutorial_SelectMountMenu = OnTutorial_SelectMountMenu,
	OnTutorial_ManaDrain = OnTutorial_ManaDrain,
	OnTutorial_IllegalMove0 = OnTutorial_IllegalMove0,
	OnTutorial_IllegalMove1 = OnTutorial_IllegalMove1,
	OnTutorial_HeroicEffort = OnTutorial_HeroicEffort,
	OnTutorial_QuestIntro = OnTutorial_QuestIntro,
	OnTutorial_QuestIntro2 = OnTutorial_QuestIntro2,
	OnTutorial_QuestMove = OnTutorial_QuestMove,
	OnTutorial_QuestAction = OnTutorial_QuestAction,
	OnTutorial_QuestMoreQuests = OnTutorial_QuestMoreQuests,
	OnTutorial_Quest_T1 = OnTutorial_Quest_T1,
	OnTutorial_Quest_T1a = OnTutorial_Quest_T1a,
	OnTutorial_Quest_T1aa = OnTutorial_Quest_T1aa,
	OnTutorial_Quest_T1b = OnTutorial_Quest_T1b,
	OnTutorial_Quest_T2 = OnTutorial_Quest_T2,
	OnTutorial_Quest_T2a = OnTutorial_Quest_T2a,
	OnTutorial_Quest_T2b = OnTutorial_Quest_T2b,
};

