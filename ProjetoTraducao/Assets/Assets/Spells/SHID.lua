--
--	HIDE
--		Sets hide status effect	
--

------------------------------------------------
--
-- CastSpell
--
--    Called to actually perform a
--    spell's effects
--
local function CastSpell(idxCaster)

	-- W.O.T.
	Std_ReceiveStatusEffect(STATUS_EFFECT_HIDDEN,0,idxCaster);	

	-- Special Effect
	Std_CastSpellEffect(idxCaster,SPELLFX_HIDE,GET_TEXT("[SPELL_SHID_NAME]"));
	
	
end


------------------------------------------------
--
-- ShouldAICastSpell
--
--    Evaluates whether an AI should cast a spell
--    Returns 1 if it should, 0 if it should not
--
local function ShouldAICastSpell(idxCaster)

	local evaluation = EVALUATE_BOARD();
	local chance = PERCENTILE_CHANCE_SYNC();
	
	if (HAS_STATUS_EFFECT(idxCaster,STATUS_EFFECT_HIDDEN)) then
		return 0;
	end
	
	-- Standard chances
	if (chance < 50) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	return 1;
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
SHID = {
   CastSpell = CastSpell,
   ShouldAICastSpell = ShouldAICastSpell,
   IsCastSpellLegal = IsCastSpellLegal,
};






