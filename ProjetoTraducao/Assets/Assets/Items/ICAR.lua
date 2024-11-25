--
--	CARAPACE
--		Protects against 1 damage and creates a red gem when hit for 2+ damage	
--


local function OnReceiveDamage(damage,sourceIdx,targetIdx)

	if (damage > 1) then 
	
		-- Damage Protection
		damage = damage - 1;

		-- Create a red gem
		-- Find a grid without a red gem on it (and no red adjacent!)
		local x,y = GetRandomGrid_Isolated(GEM_RED);
	
		-- Change it

		if (GET_GEM(x,y) ~= GEM_EMPTY) then
			SET_GEM(x,y,GEM_RED);				
			ADD_EFFECT_TO_GRID(x,y,"RedSparkle");
			PLAY_SOUND("snd_fire");

			NOTIFY_OF_ACTIVATED_ITEM();
		end
	end

	return damage;
end

--	
--		DECLARE TABLE	
--

ICAR = {
	OnReceiveDamage = OnReceiveDamage,
};




