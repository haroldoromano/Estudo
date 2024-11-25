--
--	GRID PATTERN SCRIPTS
--		
--		Scripts that are useful for pattern-matching on the grid	
--


function IsMatchingGem(gem1,gem2)
	if (
		 (gem1 == gem2) or
	     (gem1 == 5 and gem2 == 15) or
	     (gem2 == 5 and gem1 == 15) or
	     (gem1 >= 8 and gem1 <= 14 and gem2 >= 1 and gem2 <= 4) or
	     (gem2 >= 8 and gem2 <= 14 and gem1 >= 1 and gem1 <= 4)
	    ) then
			return true;
	end
	return false;
end


--
-- Get a local copy of the gem table
--
function GetLocalGemTable()

	-- Allocate the table
	local x,y;
	local gemTable = {};
	for x = 1,8 do
		gemTable[x] = {};
	end
	
	-- Assign values
	for y = 1,8 do
		for x = 1,8 do
			gemTable[x][y] = GET_GEM(x,y);
		end
	end
	
	return gemTable;
end

--
-- Buffer a gem table for speed
--	You should call this BEFORE checking for ANY patterns with the code below
--
local bufferedGemTable = {};
function BufferLocalGemTable()
	bufferedGemTable = GetLocalGemTable();
	return bufferedGemTable;
end
function GetBufferedGemTable()
	return bufferedGemTable;
end

--
-- Set up arrays for pattern searches
--  These are required to make searches more efficient for handhelds
--
local checkAcross_h = {-2,0,  1,0};
local checkAcrossPoints_h = 2;
local checkDown_h = {0,-2,   1,-2,  0,-1,  1,-1,  0,0,  1,0};
local checkDownPoints_h = 6;

local checkAcross_v = {-2,0,  -1,0,  0,0,  -2,1,  -1,1,  0,1};
local checkAcrossPoints_v = 6;
local checkDown_v = {0,-2,  0,1};
local checkDownPoints_v = 2;



--
-- Look for specific matches
--
function CheckForPatterns(gemType)
	local x,y,px,py,counter;

	-- Horizontal swaps
	for y = 1,8 do
		for x = 1,7 do
			if (IsMatchingGem(gemType,bufferedGemTable[x][y]) or
				IsMatchingGem(gemType,bufferedGemTable[x+1][y])) then
				
				-- Try a swap
				local temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
				bufferedGemTable[x+1][y] = temp;
				
				-- look for a pattern
				for counter=1,checkAcrossPoints_h do
					local counter_index = counter*2 - 1;
					px = x + checkAcross_h[counter_index];
					py = y + checkAcross_h[counter_index+1];
					if (px >= 1 and px <= 6 and py >= 1 and py <= 8 and 
						IsMatchingGem(gemType,bufferedGemTable[px][py]) and
						IsMatchingGem(gemType,bufferedGemTable[px+1][py]) and
						IsMatchingGem(gemType,bufferedGemTable[px+2][py])) then
							-- Swap back
							temp = bufferedGemTable[x][y];
							bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
							bufferedGemTable[x+1][y] = temp;
				
							return x,y,x+1,y;
					end
				end
				for counter=1,checkDownPoints_h do
					local counter_index = counter*2 - 1;
					px = x + checkDown_h[counter_index];
					py = y + checkDown_h[counter_index+1];
					if (px >= 1 and px <= 8 and py >= 1 and py <= 6 and 
						IsMatchingGem(gemType,bufferedGemTable[px][py]) and
						IsMatchingGem(gemType,bufferedGemTable[px][py+1]) and
						IsMatchingGem(gemType,bufferedGemTable[px][py+2])) then
								-- Swap back
								temp = bufferedGemTable[x][y];
								bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
								bufferedGemTable[x+1][y] = temp;
				
								return x,y,x+1,y;
					end
				end
				
				
				-- Swap back
				temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
				bufferedGemTable[x+1][y] = temp;
				
			end
			
		end
	end
	
	-- Vertical swaps
	for y = 1,7 do
		for x = 1,8 do
			if (IsMatchingGem(gemType,bufferedGemTable[x][y]) or
				IsMatchingGem(gemType,bufferedGemTable[x][y+1])) then
				
				-- Try a swap
				local temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
				bufferedGemTable[x][y+1] = temp;
				
				
				-- look for a pattern
				for counter=1,checkAcrossPoints_v do
					local counter_index = counter*2 - 1;
					px = x + checkAcross_v[counter_index];
					py = y + checkAcross_v[counter_index+1];
					if (px >= 1 and px <= 6 and py >= 1 and py <= 8 and 
						IsMatchingGem(gemType,bufferedGemTable[px][py]) and
						IsMatchingGem(gemType,bufferedGemTable[px+1][py]) and
						IsMatchingGem(gemType,bufferedGemTable[px+2][py])) then
								-- Swap back
								temp = bufferedGemTable[x][y];
								bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
								bufferedGemTable[x][y+1] = temp;
								
								return x,y,x,y+1;
					end
				end
				for counter=1,checkDownPoints_v do
					local counter_index = counter*2 - 1;
					px = x + checkDown_v[counter_index];
					py = y + checkDown_v[counter_index+1];
					if (px >= 1 and px <= 8 and py >= 1 and py <= 6 and 
							IsMatchingGem(gemType,bufferedGemTable[px][py]) and
							IsMatchingGem(gemType,bufferedGemTable[px][py+1]) and
							IsMatchingGem(gemType,bufferedGemTable[px][py+2])) then
								-- Swap back
								temp = bufferedGemTable[x][y];
								bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
								bufferedGemTable[x][y+1] = temp;
								
								return x,y,x,y+1;
					end
				end
				
				
				-- Swap back
				temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
				bufferedGemTable[x][y+1] = temp;
				
			end
			
		end
	end
	
	return -1,-1,-1,-1;
end

--
-- Look for single gems
--
function CheckForRedSkull()
	for y = 1,8 do
		for x = 1,8 do
			if (bufferedGemTable[x][y] == 15) then
				return x,y;
			end
		end
	end
	return -1,-1;
end

function CheckForWildcard()
	for y = 1,8 do
		for x = 1,8 do
			local gemType = bufferedGemTable[x][y];
			if (gemType >= 8 and gemType <= 14) then
				return x,y,gemType-6;
			end
		end
	end
	return -1,-1,0;
end

--
-- Look for specific matches
--
function CheckForSequences(numSequence)
	local x,y,px,py,tx,ty;
	
	-- Horizontal swaps
	for y = 1,8 do
		for x = 1,7 do
				
				-- Try a swap
				local temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
				bufferedGemTable[x+1][y] = temp;
				
				-- look for a pattern
				for counter=1,checkAcrossPoints_h do
					local counter_index = counter*2 - 1;
					px = x + checkAcross_h[counter_index];
					py = y + checkAcross_h[counter_index+1];
					if (px >= 1 and px <= 9-numSequence and py >= 1 and py <= 8) then
							local seqCount;
							local allMatching = true;
							local gemType = bufferedGemTable[px][py];
							if (not IsWildcard(gemType)) then
								for seqCount=1,numSequence-1 do
									if (not IsMatchingGem(gemType,bufferedGemTable[px+seqCount][py])) then
										allMatching = false;
										break;
									end
								end
								if (allMatching) then
									-- Swap back
									temp = bufferedGemTable[x][y];
									bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
									bufferedGemTable[x+1][y] = temp;
									
									return x,y,x+1,y;
								end
							end
					end
				end
				for counter=1,checkDownPoints_h do
					local counter_index = counter*2 - 1;
					px = x + checkDown_h[counter_index];
					py = y + checkDown_h[counter_index+1];
					if (px >= 1 and px <= 8 and py >= 1 and py <= 9-numSequence) then
							local seqCount;
							local allMatching = true;
							local gemType = bufferedGemTable[px][py];
							if (not IsWildcard(gemType)) then
								for seqCount=1,numSequence-1 do
									if (not IsMatchingGem(gemType,bufferedGemTable[px][py+seqCount])) then
										allMatching = false;
										break;
									end
								end
								if (allMatching) then
									-- Swap back
									temp = bufferedGemTable[x][y];
									bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
									bufferedGemTable[x+1][y] = temp;
									
									return x,y,x+1,y;
								end
							end
				
					end
				end
				
				-- Swap back
				temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x+1][y];
				bufferedGemTable[x+1][y] = temp;
		end
	end
	
	-- Vertical swaps
	for y = 1,7 do
		for x = 1,8 do
				
				-- Try a swap
				local temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
				bufferedGemTable[x][y+1] = temp;
				
				-- look for a pattern
				for counter=1,checkAcrossPoints_v do
					local counter_index = counter*2 - 1;
					px = x + checkAcross_v[counter_index];
					py = y + checkAcross_v[counter_index+1];
					if (px >= 1 and px <= 9-numSequence and py >= 1 and py <= 8) then
							local seqCount;
							local allMatching = true;
							local gemType = bufferedGemTable[px][py];
							if (not IsWildcard(gemType)) then
								for seqCount=1,numSequence-1 do
									if (not IsMatchingGem(gemType,bufferedGemTable[px+seqCount][py])) then
										allMatching = false;
										break;
									end
								end
								if (allMatching) then
								
									-- Swap back
									temp = bufferedGemTable[x][y];
									bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
									bufferedGemTable[x][y+1] = temp;
				
									return x,y,x,y+1;
								end
							end
					end
				end
				for counter=1,checkDownPoints_v do
					local counter_index = counter*2 - 1;
					px = x + checkDown_v[counter_index];
					py = y + checkDown_v[counter_index+1];
					if (px >= 1 and px <= 8 and py >= 1 and py <= 9-numSequence) then
							local seqCount;
							local allMatching = true;
							local gemType = bufferedGemTable[px][py];
							if (not IsWildcard(gemType)) then
								for seqCount=1,numSequence-1 do
									if (not IsMatchingGem(gemType,bufferedGemTable[px][py+seqCount])) then
										allMatching = false;
										break;
									end
								end
								if (allMatching) then
								
									-- Swap back
									temp = bufferedGemTable[x][y];
									bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
									bufferedGemTable[x][y+1] = temp;
				
									return x,y,x,y+1;
								end
							end
					end
				end
				
				-- Swap back
				temp = bufferedGemTable[x][y];
				bufferedGemTable[x][y] = bufferedGemTable[x][y+1];
				bufferedGemTable[x][y+1] = temp;
				
		end
	end
	
	return -1,-1,-1,-1;
end
