--
--	GRID UTILITY SCRIPTS
--		
--		Scripts that are useful for manipulating the grid	
--


--
-- Turns all special effects on/off
--
function SetMultiplierEffects(on)

	if (on) then
		SET_EXTRATURN_CHANCE_ENABLED(1);
		SET_WILDCARD_CHANCE_ENABLED(1);
		SET_DAMAGE_MULTIPLIER_ENABLED(1);
	else
		SET_EXTRATURN_CHANCE_ENABLED(0);
		SET_WILDCARD_CHANCE_ENABLED(0);
		SET_DAMAGE_MULTIPLIER_ENABLED(0);
	end
end


--
-- Counts the number of gems of a given type on the grid
--
function CountGems(typ)
	local x,y;
	local amt = 0;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == typ) then
				amt = amt + 1;
			end
		end
	end
	return amt;
end

--
-- Destroys all gems of a given type (with data effect)
--
function DestroyAllGems(typ,effect)
	local x,y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == typ) then
				DESTROY_GEM(x,y);
				if (effect ~= "") then
					ADD_EFFECT_TO_GRID(x,y,effect);
				end
			end
		end
	end
end

--
-- Removes all gems with no data effect
--
function DeleteAllGems(typ,effect)
	local x,y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == typ) then
				DELETE_GEM(x,y);
				if (effect ~= "") then
					ADD_EFFECT_TO_GRID(x,y,effect);
				end
			end
		end
	end
end

--
-- Display an effect on all gems
--
function EffectOnAllGems(typ,effect)
	local x,y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == typ) then
				ADD_EFFECT_TO_GRID(x,y,effect);
			end
		end
	end
end

--
-- Change all gems
--
function ChangeAllGems(typ1,typ2)
	local x,y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == typ1) then
				SET_GEM(x,y,typ2);
			end
		end
	end
end


--
-- Explode Gem
--
function ExplodeGem(gemx,gemy)
	local x,y;
	for y = gemy-1,gemy+1 do
		for x = gemx-1,gemx+1 do
			if (y >= 1 and y <= 8 and x >= 1 and x <= 8 and GET_GEM(x,y) ~= GEM_EMPTY) then
				DESTROY_GEM(x,y);
			end
		end
	end
end

--
-- Explode all gems
--
function ExplodeAllGems(typ1,effect)
	local x,y;
	for y = 1,8 do
		for x = 1,8 do
			if (GET_GEM(x,y) == typ1) then
				ExplodeGem(x,y);
				if (effect ~= "") then
					ADD_EFFECT_TO_GRID(x,y,effect);
				end
			end
		end
	end
end



