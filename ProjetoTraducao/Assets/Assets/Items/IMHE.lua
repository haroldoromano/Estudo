--
--	MIRROR HELM
--		Reflects 1 damage 	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)
	if (damage > 1 and sourceIdx ~= targetIdx) then 
		SUBTRACT_LIFE(sourceIdx,1,targetIdx);
		NOTIFY_OF_ACTIVATED_ITEM();

		-- Special Effect
		local charx	= GET_CHARACTER_X(targetIdx);
		local chary	= GET_CHARACTER_Y(targetIdx);
		local enemyx	= GET_CHARACTER_X(sourceIdx);
		local enemyy	= GET_CHARACTER_Y(sourceIdx);
		ADD_LIGHTNING(charx,chary,enemyx,enemyy,1.2);
		ADD_ANIMEFFECT_TO_CHARACTER(targetIdx,"BlueWave");
		ADD_EFFECT_TO_CHARACTER(sourceIdx,"CyanSparkle");
	end
	return damage;
end

--	
--		DECLARE TABLE	
--

IMHE = {
	OnReceiveDamage = OnReceiveDamage,
};






