local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )

local physics = require( "physics")
physics.start( )

function scene:createScene( event )
storyboard.removeAll()

local group = self.view

local _W = display.contentWidth
local _H = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

display.setStatusBar(display.HiddenStatusBar)

local select = audio.loadSound("select.wav")


local background = display.newImageRect( "imagens/background.png",_W,_H )
background.x = centerX
background.y=centerY
group:insert(background)

local titulo = display.newImageRect( "imagens/titulo.png",_W*0.7,_H*0.5 )
titulo.x = centerX 
titulo.y = centerY*0.6
group:insert(titulo)



local play = widget.newButton
{
    width =_W*0.4,
    height = _H*0.1,
    defaultFile = "imagens/play.png",
    overFile = "imagens/play2.png",
    --label = "button",
    onEvent = play_tap
}

-- Center the button
play.x = centerX
play.y = centerY*1.3

group:insert(play)


local help = widget.newButton
{
    width =_W*0.4,
    height = _H*0.10,
    defaultFile = "imagens/help.png",
    overFile = "imagens/help2.png",
    --label = "button",
    onEvent = help_tap
}

-- Center the button
help.x = centerX
help.y = centerY*1.6

group:insert(help)

require("sounds")

audio.play(music)

function play_tap (event)
  audio.play( select )
	storyboard.gotoScene( "selecaodecenas", "slideRight" )
end

function help_tap (event)
  audio.play( select )
	storyboard.gotoScene( "help", "slideRight" )
end


play:addEventListener( "tap",play_tap )

help:addEventListener( "tap",help_tap )



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



