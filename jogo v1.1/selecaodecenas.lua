local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


display.setStatusBar(display.HiddenStatusBar)
 -->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function scene:createScene( event )
storyboard.removeAll()

local group = self.view

local _W = display.contentWidth
local _H = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local widget = require( "widget" )

require("sounds")

local lvl = {}
local select = audio.loadSound("sounds/select.wav")

local background = display.newImageRect( "imagens/background.png",_W,_H )
background.x = centerX
background.y=centerY

group:insert(background)


-- local back = display.newImageRect( "imagens/back.png",_W*0.15,_H*0.10 )
-- back.x = centerX * 0.2
-- back.y = centerY * 1.8

local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        storyboard.gotoScene("menu","slideLeft")
    end
end

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


local cena1 = widget.newButton
{
    width =_W*0.1,
    height = _H*0.15,
    defaultFile = "imagens/lvl.png",
    overFile = "imagens/lvl.png",
    --label = "button",
    onEvent = lvl_tap
}

-- Center the button
cena1.x = centerX*0.6
cena1.y = centerY*0.4


group:insert(cena1)



lvl[2] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[2].x = cena1.x + 100
lvl[2].y = centerY * 0.4
group:insert(lvl[2])

lvl[3] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[3].x = lvl[2].x + 100
lvl[3].y = centerY * 0.4
group:insert(lvl[3])

lvl[4] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[4].x = cena1.x 
lvl[4].y = cena1.y + 70
group:insert(lvl[4])

lvl[5] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[5].x = lvl[4].x + 100
lvl[5].y = lvl[4].y 
group:insert(lvl[5])

lvl[6] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[6].x = lvl[5].x + 100
lvl[6].y = lvl[4].y 
group:insert(lvl[6])


lvl[7] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[7].x = cena1.x 
lvl[7].y = lvl[4].y + 70
group:insert(lvl[7])

lvl[8] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[8].x = lvl[7].x + 100
lvl[8].y = lvl[7].y 
group:insert(lvl[8])

lvl[9] = display.newImageRect( "imagens/lvlblock.png",_W*0.1,_H*0.15 )
lvl[9].x = lvl[8].x + 100
lvl[9].y = lvl[7].y 
group:insert(lvl[9])


function lvl_tap (event)
  audio.play( select )
  storyboard.gotoScene( "cena1", "fade", 300 )
end

cena1:addEventListener( "tap",lvl_tap )

end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
local group = self.view

-----------------------------------------------------------------------------

--      This event requires build 2012.782 or later.

-----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
local group = self.view



-----------------------------------------------------------------------------

--      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

-----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
local group = self.view

group:removeSelf()


-----------------------------------------------------------------------------

--      INSERT code here (e.g. sbaseBorda timers, remove listeners, unload sounds, etc.)

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

-----------------------------------------------------------------------------

--      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

-----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
local group = self.view
local overlay_name = event.sceneName  -- name of the overlay scene

-----------------------------------------------------------------------------

--      This event requires build 2012.797 or later.

-----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
local group = self.view
local overlay_name = event.sceneName  -- name of the overlay scene

-----------------------------------------------------------------------------

--      This event requires build 2012.797 or later.

-----------------------------------------------------------------------------

end

scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene



