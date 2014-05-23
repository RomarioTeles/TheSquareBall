local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require( "physics")
physics.start( )
local widget = require( "widget" )



local _W = display.contentWidth
local _H = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        storyboard.gotoScene("menu","slideLeft")
    end
end


function scene:createScene( event )
local group = self.view
require("sounds")

local background = display.newImageRect( "imagens/bkg.png",_W,_H )
background.x = centerX
background.y=centerY

group:insert(background)

local ground = display.newImageRect( "imagens/ground.png",_W,_H/5 )
ground.x = centerX
ground.y=centerY *1.8
physics.addBody( ground,"static" )
ground.myName="ground"

group:insert(ground)

local borderLeft = display.newRect(0,centerY,1,_H)
borderLeft:setFillColor(0,0,0,0)
physics.addBody(borderLeft,"static")
group:insert(borderLeft)

local borderRigth = display.newRect(_W,centerY,1,_H)
borderRigth:setFillColor(0,0,0,0)
physics.addBody(borderRigth,"static")
group:insert(borderRigth)

player = display.newImageRect( "imagens/bola.png", _H * 0.085, _H * 0.085)
player.x = centerX 
player.y = centerY * 1.4
physics.addBody( player, 'dynamic', { radius = 15,friction = 0.2, density=0.01,  bounce=0.5} )
player.myName = "bola"
group:insert(player)

local controleDepulos = false

local screen_tap = function( event )
    
       if(player.setLinearVelocity ~= nil)then
        player:setLinearVelocity( 0, 0)
         end
        if (player.applyForce ~=nil)then
                    if (event.x < centerX)  then
        	       print(controleDepulos)
                    	if event.numTaps == 2 and controleDePulos == true then
                    	   controleDePulos=false
                           player:applyForce( -0.6, -2, player.x, player.y )
                           audio.play( jump )
                    	
                        else 
                        	 player:applyForce( -0.6, 0, player.x, player.y )
                       	end
                    elseif event.x > centerX  then

                    	if event.numTaps == 2 and controleDePulos == true then
                    		controleDePulos=false
                    		player:applyForce( 0.6, -2, player.x, player.y )
                    		audio.play( jump )
                    		else 
                    			player:applyForce( 0.6, 0, player.x, player.y )
                    		end
            end
        end
end
    	

function onGroundCollision(event)
	if ( event.phase == "began" ) then 
		if (event.object1.myName == "ground" and event.object2.myName=="bola") then			
	    	controleDePulos = true
		end
	end
end


local helpTextL = display.newText("Tap the screen \nonce to move the ball.",centerX*0.45,centerY*1.3,nil,20)
group:insert(helpTextL)

local helpTextR = display.newText("Double-tap the screen \nto jump.",centerX*1.6,centerY,nil,20)
group:insert(helpTextR)


local helpTextT = display.newText("You can choose one of the  \nsides of the screen right or left..",centerX,centerY*0.6,nil,20)
group:insert(helpTextT)

local back = widget.newButton
{
    width =_W*0.15,
    height = _H*0.10,
    defaultFile = "imagens/back.png",
    overFile = "imagens/back2.png",
    --label = "button",
    onEvent = handleButtonEvent
}

-- Center the button
back.x = centerX*0.2
back.y = centerY*1.8


group:insert(back)

Runtime:addEventListener('collision', onGroundCollision)
Runtime:addEventListener( 'tap', screen_tap )
        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------

end



function scene:enterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        
Runtime:removeEventListener('collision', onGroundCollision)
Runtime:removeEventListener( 'tap', screen_tap )

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end

-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
local group = self.view


-----------------------------------------------------------------------------

--      This event requires build 2012.782 or later.

-----------------------------------------------------------------------------

end



-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view
        --group:removeSelf()
        -----------------------------------------------------------------------------
----------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
-------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "destroyScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "didExitScene", scene )


-- "didExitScene" event is dispatched after scene has finished transitioning out


---------------------------------------------------------------------------------

return scene