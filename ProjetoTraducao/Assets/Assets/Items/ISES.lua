--
--	SIR ECTORS SWORD
--		+1 Damage AND Upon receiving XP the sword randomly creates a skull  	
--


local function OnGiveDamage(damage,sourceIdx,targetIdx)
	if (damage >= 3) then 
		damage = damage + 1;
		NOTIFY_OF_ACTIVATED_ITEM();
	end
	return damage;
end

local function OnReceiveXP(value,characterIdx)

	if (PERCENTILE_CHANCE_SYNC() <= 50 and not IS_GAME_OVER()) then
		local x,y;
		x,y = GetRandomGrid_Isolated2(GEM_SKULL, GEM_STAR);
		if (GET_GEM(x,y) ~= GEM_STAR and GET_GEM(x,y) ~= GEM_SKULL) then
			SET_GEM(x,y,GEM_SKULL);
			ADD_EFFECT_TO_GRID(x,y,"WhiteSparkle");
			NOTIFY_OF_ACTIVATED_ITEM();
			PLAY_SOUND("snd_stone");		
		end
	end

	return value;
end


--	
--		DECLARE TABLE	
--

ISES = {
	OnGiveDamage = OnGiveDamage,
	OnReceiveXP = OnReceiveXP,
};




