--
--	STANDARD CONSTANTS
--		
--		All constants that the scripts will need	
--

--------------------------------------------------------------------------------------
--
--										Platforms
--
PLATFORM_PC = 0;
PLATFORM_XBOX360 = 1;
PLATFORM_PSP = 2;
PLATFORM_DS = 3;
PLATFORM_WII = 4;
PLATFORM_PS2 = 5;

--------------------------------------------------------------------------------------
--
--										Gem Types
--
GEM_EMPTY = 0;
GEM_EARTH = 1;
GEM_FIRE = 2;
GEM_AIR = 3;
GEM_WATER = 4;
GEM_SKULL = 5;
GEM_STAR = 6;
GEM_GOLD = 7;
GEM_WILDCARDx2 = 8;
GEM_WILDCARDx3 = 9;
GEM_WILDCARDx4 = 10;
GEM_WILDCARDx5 = 11;
GEM_WILDCARDx6 = 12;
GEM_WILDCARDx7 = 13;
GEM_WILDCARDx8 = 14;
GEM_REDSKULL = 15;

GEM_YELLOW = GEM_AIR;
GEM_GREEN = GEM_EARTH;
GEM_RED = GEM_FIRE;
GEM_BLUE = GEM_WATER;
GEM_XP = GEM_STAR;

function IsWildcard(typ)
	if (typ >= GEM_WILDCARDx2 and typ <= GEM_WILDCARDx8) then
		return true;
	end
	return false;
end

function IsSkull(typ)
	if (typ == GEM_SKULL or typ == GEM_REDSKULL) then
		return true;
	end
	return false;
end


--------------------------------------------------------------------------------------
--
--										Status Effects
--

STATUS_EFFECT_BLIND 		= "EBLI";
STATUS_EFFECT_CHALLENGED	= "ECHA";
STATUS_EFFECT_DISEASE		= "EDIS";
STATUS_EFFECT_ENRAGED		= "EENR";
STATUS_EFFECT_FAVORED		= "EFAV";
STATUS_EFFECT_FEAR			= "EFEA";
STATUS_EFFECT_FIRESHIELD	= "EFSH";
STATUS_EFFECT_HANDOFPOWER 	= "EHOP";
STATUS_EFFECT_HASTE		 	= "EHAS";
STATUS_EFFECT_HIDDEN	 	= "EHID";
STATUS_EFFECT_PALADINSAURA	= "EPAU";
STATUS_EFFECT_POISON		= "EPOI";
STATUS_EFFECT_VIGIL			= "EVIG";
STATUS_EFFECT_WALLOFTHORNS	= "EWOT";
STATUS_EFFECT_WALLOFFIRE	= "EWOF";
STATUS_EFFECT_SINGINGBLADES	= "ESBL";
STATUS_EFFECT_DOOMED		= "EDOO";

--------------------------------------------------------------------------------------
--
--										Character Skills
--

SKILL_EARTH = 0;
SKILL_FIRE = 1;
SKILL_AIR = 2;
SKILL_WATER = 3;
SKILL_BATTLE = 4;
SKILL_CUNNING = 5;
SKILL_MORALE = 6;


--------------------------------------------------------------------------------------
--
--										Mana Types
--

MANA_GREEN = 0;
MANA_RED = 1;
MANA_YELLOW = 2;
MANA_BLUE = 3;
MANA_EARTH = MANA_GREEN;
MANA_FIRE = MANA_RED;
MANA_AIR = MANA_YELLOW;
MANA_WATER = MANA_BLUE;


--------------------------------------------------------------------------------------
--
--										Text Messages
--
MESSAGE_RED		= 0;
MESSAGE_YELLOW	= 1;
MESSAGE_GREEN	= 2;
MESSAGE_CYAN	= 3;
MESSAGE_PURPLE	= 4;
MESSAGE_ORANGE	= 5;
MESSAGE_WHITE	= 6;

--------------------------------------------------------------------------------------
--
--										Special Effects
--
EFFECT_RED_SPARKLE		= "RedSparkle";
EFFECT_WHITE_SPARKLE	= "WhiteSparkle";
EFFECT_GREEN_SPARKLE	= "GreenSparkle";
EFFECT_YELLOW_SPARKLE	= "YellowSparkle";
EFFECT_CYAN_SPARKLE		= "CyanSparkle";
EFFECT_BLUE_SPARKLE		= "CyanSparkle";
EFFECT_PURPLE_SPARKLE	= "PurpleSparkle";
EFFECT_SPELL0			= "Spell0";
EFFECT_SPELL1			= "Spell1";
EFFECT_REDSKULL			= "RedSkull";

--------------------------------------------------------------------------------------
--
--										Rune Types
--
RUNE_BASE				= 0;
RUNE_MODIFIER			= 1;
RUNE_POWER				= 2;

--------------------------------------------------------------------------------------
--
--										City Status
--
CITYSTATUS_AVAILABLE		= 0;
CITYSTATUS_START			= 1;
CITYSTATUS_SIEGEONLY		= 2;
CITYSTATUS_CLOSED			= 3;
CITYSTATUS_CLOSEDWITHQUESTS = 4;

--------------------------------------------------------------------------------------
--
--										Standard Spell Effects
--
SPELLFX_DEFAULTGFXONLY		= -3;
SPELLFX_DEFAULTSOUNDONLY	= -2;
SPELLFX_NONE				= -1;
SPELLFX_DEFAULT				= 0;
SPELLFX_HEALING				= 1;
SPELLFX_NECRO				= 2;
SPELLFX_WATER				= 3;
SPELLFX_AIR					= 4;
SPELLFX_FROST				= 5;
SPELLFX_REPLACEME			= 6;
SPELLFX_SYMBOL				= 7;
SPELLFX_CHAOS				= 8;
SPELLFX_GOOD				= 9;
SPELLFX_STONE				= 10;
SPELLFX_HIDE				= 11;
SPELLFX_WAR					= 12;
SPELLFX_NATURE				= 13;
SPELLFX_STUN				= 14;
SPELLFX_FIREBALL			= 15;
SPELLFX_HURLGOBLIN			= 16;
SPELLFX_POISON				= 17;
SPELLFX_DISEASE				= 18;
SPELLFX_WEB					= 19;
SPELLFX_FEAR				= 20;
SPELLFX_SPIN				= 21;
SPELLFX_SPARKLE				= 22;

--------------------------------------------------------------------------------------

