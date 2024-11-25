--
--	SINGING BLADES
--		Reduce all enemy mana by 4
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)

	-- GREEN MANA
	local mana = GET_MANA_EARTH(targetIdx);
	mana = mana-4;
	if (mana < 0) then
		mana = 0;
	end
	SET_MANA_EARTH(targetIdx,mana);

	-- RED MANA
	mana = GET_MANA_FIRE(targetIdx);
	mana = mana-4;
	if (mana < 0) then
		mana = 0;
	end
	SET_MANA_FIRE(targetIdx,mana);

	-- YELLOW MANA
	mana = GET_MANA_AIR(targetIdx);
	mana = mana-4;
	if (mana < 0) then
		mana = 0;
	end
	SET_MANA_AIR(targetIdx,mana);

	-- BLUE MANA
	mana = GET_MANA_WATER(targetIdx);
	mana = mana-4;
	if (mana < 0) then
		mana = 0;
	end
	SET_MANA_WATER(targetIdx,mana);

	return damage;
end

--	
--		DECLARE TABLE	
--

SingingBladesed = {
	OnGiveDamage = OnGiveDamage,
};

