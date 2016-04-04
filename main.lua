-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--width = 320,
--height = 480, 

--https://coronalabs.com/blog/2014/01/07/tutorial-moving-objects-along-a-path/

local widget = require( "widget" )
local p = require("path")

local function handleButtonEvent( event )
	
	 if ( "began" == event.phase ) then
		print( "on" )
		transition.pause( "moveObject" )
	 end


    if ( "ended" == event.phase ) then
        print( "off" )
		transition.resume( "moveObject" )
    end
end


-- Create the widget
local button1 = widget.newButton(
    {
        label = "button",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 200,
        height = 40,
        cornerRadius = 2,
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)

-- Center the button
button1.x = display.contentCenterX
button1.y = 400

-- Change the button's label text
button1:setLabel( "HOLD" )

local movePath = {}

movePath[1] = { x=50, y=50 }
movePath[2] = { x=50, y=200 }
movePath[3] = { x=200, y=200 }
movePath[4] = { x=200, y=30}

p.drawPath( movePath )

local player = display.newRect( 0, 0, 20, 20 )
player:setFillColor( 0.9, 0.2, 0.7 )

p.setPath( player, movePath, { useDelta=false, constantTime=1200, easingMethod=nil, tag="moveObject" } )

--Runtime:addEventListener( "enterFrame", tick )