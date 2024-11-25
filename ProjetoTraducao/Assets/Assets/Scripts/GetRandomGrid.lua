--
--	RANDOM GRID FUNCTIONS
--		
--

function NoAdjacentGems(x,y,typ)
	if (x > 1 and (GET_GEM(x-1,y) == typ)) then
		return false;
	end
	if (x < 8 and (GET_GEM(x+1,y) == typ)) then
		return false;
	end
	if (y > 1 and (GET_GEM(x,y-1) == typ)) then
		return false;
	end
	if (y < 8 and (GET_GEM(x,y+1) == typ)) then
		return false;
	end
	return true;	   
end


function GetRandomGrid()
	local x = GET_RANDOM_SYNC(1,8);
	local y = GET_RANDOM_SYNC(1,8);
	return x,y;
end

function GetRandomGrid_Not(typ1)
	local done = false;
	local tries = 0;
	local x;
	local y;
	repeat
		x,y = GetRandomGrid();
		if (GET_GEM(x,y) ~= typ1) then
			done = true;
		end
		tries = tries+1;
	until (tries > 1000 or done)
	return x,y;
end

function GetRandomGrid_Not2(typ1,typ2)
	local done = false;
	local tries = 0;
	local x;
	local y;
	repeat
		x,y = GetRandomGrid();
		if (GET_GEM(x,y) ~= typ1 and GET_GEM(x,y) ~= typ2) then
			done = true;
		end
		tries = tries+1;
	until (tries > 1000 or done)
	return x,y;
end

function GetRandomGrid_Not3(typ1,typ2,typ3)
	local done = false;
	local tries = 0;
	local x;
	local y;
	repeat
		x,y = GetRandomGrid();
		if (GET_GEM(x,y) ~= typ1 and GET_GEM(x,y) ~= typ2 and GET_GEM(x,y) ~= typ3) then
			done = true;
		end
		tries = tries+1;
	until (tries > 1000 or done)
	return x,y;
end

function GetRandomGrid_Isolated(typ1)
	local done = false;
	local tries = 0;
	local x;
	local y;
	repeat
		x,y = GetRandomGrid();
		if (GET_GEM(x,y) ~= typ1) then
			if (NoAdjacentGems(x,y,typ1)) then
				done = true;
			end
		end
		tries = tries+1;
	until (tries > 1000 or done)
	return x,y;
end

function GetRandomGrid_Isolated2(typ1,typ2)
	local done = false;
	local tries = 0;
	local x;
	local y;
	repeat
		x,y = GetRandomGrid();
		if (GET_GEM(x,y) ~= typ1 and GET_GEM(x,y) ~= typ2) then
			if (NoAdjacentGems(x,y,typ1) and NoAdjacentGems(x,y,typ2)) then
				done = true;
			end
		end
		tries = tries+1;
	until (tries > 1000 or done)
	return x,y;
end

function GetRandomGrid_Type(typ1)
	local done = false;
	local tries = 0;
	local x;
	local y;
	repeat
		x,y = GetRandomGrid();
		if (GET_GEM(x,y) == typ1) then
			done = true;
		end
		tries = tries+1;
	until (tries > 1000 or done)
	return x,y;
end

function GetRandomGrid_Type2(typ1,typ2)
	local done = false;
	local tries = 0;
	local x;
	local y;
	repeat
		x,y = GetRandomGrid();
		if (GET_GEM(x,y) == typ1 or GET_GEM(x,y) == typ2) then
			done = true;
		end
		tries = tries+1;
	until (tries > 1000 or done)
	return x,y;
end

