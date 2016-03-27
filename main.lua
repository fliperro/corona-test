-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--https://coronalabs.com/blog/2014/01/07/tutorial-moving-objects-along-a-path/

local movePath = {}
movePath[1] = { x=50, y=50 }
movePath[2] = { x=50, y=200 }
movePath[3] = { x=200, y=200 }
movePath[4] = { x=200, y=30}

local function distBetween( x1, y1, x2, y2 )
   local xFactor = x2 - x1
   local yFactor = y2 - y1
   local dist = math.sqrt( (xFactor*xFactor) + (yFactor*yFactor) )
   return dist
end


--player.x = movePath[1].x
--player.y = movePath[1].y

local function drawPath( path ) 
	for i = 1,#path do
		if (i < #path) then
		
		display.newLine(path[i].x, path[i].y, path[i+1].x, path[i+1].y)
		
		end
	
	end

end

drawPath( movePath )

local player = display.newRect( 0, 0, 20, 20 )
player:setFillColor( 0.7, 0.7, 0.7 )

local function setPath( object, path, params )
 
	local delta = params.useDelta or nil
	local deltaX = 0
	local deltaY = 0
	local constant = params.constantTime or nil
	local ease = params.easingMethod or easing.linear
	local tag = params.tag or nil
	local delay = params.delay or 0
	local speedFactor = 1
   
	if ( delta ) then
		deltaX = object.x
		deltaY = object.y
	end
   
	if ( constant ) then
		local dist = distBetween( object.x, object.y, deltaX+path[1].x, deltaY+path[1].y )
		speedFactor = constant/dist
	end
   
	for i = 1,#path do
	
		if (i == 1) then
		
			object.x = path[i].x
			object.y = path[i].y
		
		else
			local segmentTime = 500
 
		--if "constant" is defined, refactor transition time based on distance between points
		if ( constant ) then
			local dist
			--if ( i == 1 ) then
			--	dist = distBetween( object.x, object.y, deltaX+path[i].x, deltaY+path[i].y )
			--else
				dist = distBetween( path[i-1].x, path[i-1].y, path[i].x, path[i].y )
			--end
			segmentTime = dist*speedFactor
		else
			--if this path segment has a custom time, use it
			if ( path[i].time ) then segmentTime = path[i].time end
		end
		
		 --if this segment has custom easing, override the default method (if any)
		if ( path[i].easingMethod ) then ease = path[i].easingMethod end

		transition.to( object, { tag=tag, time=segmentTime, x=deltaX+path[i].x, y=deltaY+path[i].y, delay=delay, transition=ease } )
		delay = delay + segmentTime
		end
	
 
		
	end
end



setPath( player, movePath, { useDelta=false, constantTime=1200, easingMethod=nil, tag="moveObject" } )

--Runtime:addEventListener( "enterFrame", tick )