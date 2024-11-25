--
--	DUPLICATE
--		Duplicates an enemy item	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	local legalList = {};
	local legalListSize = 0;
	local idxEnemy = GET_ENEMY(idxCaster,0);
 
	-- Find possibilities
	if (GET_ITEM(idxEnemy,0) ~= GET_ITEM(idxCaster,0) and 
          GET_ITEM(idxEnemy,0) ~= "") then
		legalList[legalListSize] = 0;
		legalListSize = legalListSize + 1;
	end
	if (GET_ITEM(idxEnemy,1) ~= GET_ITEM(idxCaster,1) and 
          GET_ITEM(idxEnemy,1) ~= "") then
		legalList[legalListSize] = 1;
		legalListSize = legalListSize + 1;
	end
	if (GET_ITEM(idxEnemy,2) ~= GET_ITEM(idxCaster,2) and 
          GET_ITEM(idxEnemy,2) ~= "") then
		legalList[legalListSize] = 2;
		legalListSize = legalListSize + 1;
	end
	if (GET_ITEM(idxEnemy,3) ~= GET_ITEM(idxCaster,3) and 
          GET_ITEM(idxEnemy,3) ~= "") then
		legalList[legalListSize] = 3;
		legalListSize = legalListSize + 1;
	end

	-- Now pick one
	local myMessage = GET_TEXT("[SPELL_EFFECT_DUPLICATE0]");
	if (legalListSize > 0) then
		local myChoice = GET_RANDOM_SYNC(0,legalListSize-1);
		local myItem = legalList[myChoice];
		SET_ITEM(idxCaster,myItem,GET_ITEM(idxEnemy,myItem));
		myMessage = GET_TEXT("[SPELL_EFFECT_DUPLICATE1]");
	end

	-- Special FX on caster
	Std_CastSpellEffect(idxCaster,SPELLFX_SYMBOL,myMessage );
	Std_EnemySpellEffect(idxCaster,SPELLFX_SYMBOL,0);
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local idxEnemy = GET_ENEMY(idxCaster,0);
	
	local bonus=-100;
	if (	(GET_ITEM(idxEnemy,0) ~= GET_ITEM(idxCaster,0) and GET_ITEM(idxEnemy,0) ~= "") or
 		(GET_ITEM(idxEnemy,1) ~= GET_ITEM(idxCaster,1) and GET_ITEM(idxEnemy,1) ~= "") or
		(GET_ITEM(idxEnemy,2) ~= GET_ITEM(idxCaster,2) and GET_ITEM(idxEnemy,2) ~= "") or
		(GET_ITEM(idxEnemy,3) ~= GET_ITEM(idxCaster,3) and GET_ITEM(idxEnemy,3) ~= "")) then

		bonus = 50;
	end

	return Std_AISpellcastingChance(bonus);
end


------------------------------------------------
--
-- IsCastSpellLegal
--
--    Called to check if a spell may be cast
--    Returns 1 if it can, 0 if it cannot
--
local function IsCastSpellLegal(idxCaster)

   return 1;
end


--
--     DECLARE TABLE
--
SDUP = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};










