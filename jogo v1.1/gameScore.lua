local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --
local _W = display.contentWidth
local _H = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY


if "Win" == system.getInfo( "platformName" ) then 
                fonte = "Anja Eliane" 
        elseif "Android" == system.getInfo( "platformName" ) then 
                fonte = "Anja Heliane" 
end



---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local function gameOverEnded(event)
	if(event.phase == "ended") then
		print("debug")
		storyboard.hideOverlay()
                storyboard.gotoScene("cenar")
	end
end


local function nextSceneEnded(event)
        if(event.phase == "ended") then
                print("debug")
                storyboard.hideOverlay()
                storyboard.gotoScene("selecaodecenas")
        end
end

local function menuSelecaoEnded(event)
        if(event.phase == "ended") then
                print("debug")
                storyboard.hideOverlay()
                storyboard.gotoScene("selecaodecenas")
        end
end



-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
		
        
        gameOver = display.newImageRect("imagens/score.png", _W*0.5, _H*0.7)
        gameOver.x = centerX
        gameOver.y = centerY

        chooiceIcon = display.newImageRect("imagens/selecaodecenaicon.png", _W*0.1, _W*0.1)
        chooiceIcon.x = centerX*0.75
        chooiceIcon.y=centerY*1.5

        restartIcon = display.newImageRect("imagens/restartcena.png", _W*0.1, _W*0.1)
        restartIcon.x = chooiceIcon.x + 60
        restartIcon.y=centerY*1.5

        nextCenaIcon = display.newImageRect("imagens/nextcena.png", _W*0.1,_W*0.1)
        nextCenaIcon.x = restartIcon.x+60
        nextCenaIcon.y= centerY*1.5

        scoreText = display.newText(""..nummoedas, centerX,centerY*1.135, fonte, 25)
        scoreText:setFillColor(0,0,0)
		
		group:insert(gameOver)
		group:insert(chooiceIcon)
		group:insert(restartIcon)
		group:insert(scoreText)
                group:insert(nextCenaIcon)
        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------

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
		
		restartIcon:addEventListener("touch",gameOverEnded)
                chooiceIcon:addEventListener("touch",menuSelecaoEnded)
                nextCenaIcon:addEventListener("touch",nextSceneEnded)

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

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



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
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