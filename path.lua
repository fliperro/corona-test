local Path = {}




function Path.distBetween( x1, y1, x2, y2 )
   local xFactor = x2 - x1
   local yFactor = y2 - y1
   local dist = math.sqrt( (xFactor*xFactor) + (yFactor*yFactor) )
   return dist
end


function Path.drawPath( path ) 
	for i = 1,#path do
		if (i < #path) then		
			display.newLine(path[i].x, path[i].y, path[i+1].x, path[i+1].y)
		end	
	end
end

function Path.setPath( object, path, params )
 
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
		local dist = Path.distBetween( object.x, object.y, deltaX+path[1].x, deltaY+path[1].y )
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
				dist = Path.distBetween( path[i-1].x, path[i-1].y, path[i].x, path[i].y )
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

return Path