local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local physics = require( "physics")
physics.start( )

require("movieclip" )
local widget = require( "widget" )


local _W = display.contentWidth
local  _H = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local controleDePulos = false

local tries = 3
local live = {}
local fonte=""
local superGround = {}
local background = {}
local plataforma = {}
local diamante = {}
local ground = {}
local arvore={}
local bomba = {}
local moeda = {}
local cano = {}
local chama={}


local muteOn = false 
--local moedas
--local game
local seta
--local cena

--bordas
local borderLeft
local borderRight
local borderTop


if "Win" == system.getInfo( "platformName" ) then 
		fonte = "Anja Eliane" 
	elseif "Android" == system.getInfo( "platformName" ) then 
		fonte = "Anja Heliane" 
end


function tap_restart(event)
	print("tap_restart")
	storyboard.reloadScene()

end


function mute(event)

	if(muteOn == false) then
		muteOn = true
		audio.pause(music)
        else
        	muteOn = false
        	audio.resume(music)

    end

end



local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
   		--storyboard:removeScene(storyboard.getCurrentSceneName())
        storyboard.gotoScene("menu","slideLeft")
    end
end


function onAnelCollision(event)

	if ( event.phase == "began" ) then 
		if (event.object1.myName == "anel" and event.object2.myName=="bola") then
			storyboard.showOverlay("gameScore")
		end

	end
end


function onmoedaCollision(event)
	if ( event.phase == "began" ) then 
		if (event.object1.myName == "moeda" and event.object2.myName=="bola") then			
	    	event.object1:removeSelf()
			audio.play(coins)
			nummoedas = nummoedas + 1
			nummoedasText.text = ""..nummoedas
			local win = display.newImageRect("imagens/+1.png",_W*0.05,_W*0.05)
			win.x=centerX
			win.y=centerY			
			transition.to( win,{time=3000, x = showmoeda.x, y= showmoeda.y, alpha=0} )
			--transition.to( win,{time=3000, x = nummoedasText.x, y=nummoedasText.y, alpha=0} )
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

function onBombaCollision(event)
	
	if ( event.phase == "began" ) then
		if (event.object1.myName == "bomba" and event.object2.myName=="bola") then
			if(tries == 1) then
				Runtime:removeEventListener( "enterFrame",moveCamera )
				audio.play( hurt )
				tries=tries-1
				--local lose = display.newText("Game Over", centerX , centerY, "cake", 24) 
				--lose:setFillColor(1,0,0);
				live[3].alpha=0
				showmoeda.alpha = 0
				nummoedasText.alpha=0
				moedabar.alpha=0
				player:removeSelf()
				--mountGameOverDisplay( )
				storyboard.showOverlay("gameOverScene")
				
			else
				controleDePulos = true
				audio.play( hurt)
				tries = tries -1

				if(live[1].alpha ==1 ) then
					
						live[1].alpha=0				
					else if (live[1].alpha==0 and live[2].alpha==1) then
						live[2].alpha=0
					end	
				end				
			end

		end
		
	elseif ( event.phase == "ended" ) then				
	end

end


local screen_tap = function( event )
	if(player.setLinearVelocity ~= nil)then
		player:setLinearVelocity( 0, 0)
	end
	if (event.x < centerX)  then
		print(controleDepulos)
		if event.numTaps == 2 and controleDePulos == true then
		   controleDePulos=false
	       player:applyForce( -0.6, -2, player.x, player.y )
	       audio.play( jump )
		
	    else 
	    	 player:applyForce( -0.8, 0, player.x, player.y )
	   	end
	elseif event.x > centerX  then

		if event.numTaps == 2 and controleDePulos == true then
			controleDePulos=false
			player:applyForce( 0.6, -2, player.x, player.y )
			audio.play( jump )
			else 
				if(player.applyForce ~= nil)then
					player:applyForce( 0.8, 0, player.x, player.y )
				end
			end
	end
end


function scene:createScene( event )
storyboard.removeAll()
local group = self.view


local cena = display.newGroup( )
local game = display.newGroup( )
local moedas = display.newGroup( )



 audio.play(music)

local muteSoundsIcon = display.newImageRect("imagens/somIcone.png",_W*0.08,_H*0.07)
muteSoundsIcon.x = centerX*1.8
muteSoundsIcon.y = centerY*1.8
cena:insert(muteSoundsIcon)


local coins = audio.loadSound("sons/pickupGold.wav")
local hurt = audio.loadSound( "sons/hurt.wav" )
local jump = audio.loadSound( "sons/jump.wav" )
local  music = audio.loadStream("sons/trilha.mp3")


function geraCenario(j)

	for i=1,j do
		if (i==1) then
			background[i] = display.newImageRect( "imagens/bkg.png",_W,_H )
			background[i].x = centerX
			background[i].y=centerY
			game:insert( background[i] )


			ground[i] = display.newImageRect( "imagens/ground.png",_W,_H/5 )
			ground[i].x = centerX
			ground[i].y=centerY *1.8
			game:insert(ground[i])
			physics.addBody( ground[i],"static" )
			ground[i].myName="ground"

		else
			local a = i-1
			background[i] = display.newImageRect( "imagens/bkg.png",_W,_H )
			background[i].x = background[a].x+_W
			background[i].y=centerY
			game:insert( background[i] )


			ground[i] = display.newImageRect( "imagens/ground.png",_W,_H/5 )
			ground[i].x = ground[a].x+_W
			ground[i].y=centerY *1.8
			game:insert(ground[i])
			physics.addBody( ground[i],"static" )
			ground[i].myName="ground"


		end	

	end
end

geraCenario(8)

function geraArvores(x,y,j,d)

	for i=1,j do
		if (i==1) then
			arvore[i] = display.newImageRect( "imagens/arvore2.png",_W*0.3,_W*0.3 )
			arvore[i].x = x
			arvore[i].y= y
			game:insert( arvore[i] )
		else
			local a = i-1
			local path = math.random(2)
			if (path == 1) then
				arvore[i] = display.newImageRect( "imagens/arvore1.png",_W*0.3,_W*0.3 )
				arvore[i].x = arvore[a].x+d
				arvore[i].y=y
				game:insert( arvore[i] )
			else
				arvore[i] = display.newImageRect( "imagens/arvore2.png",_W*0.3,_W*0.3 )
				arvore[i].x = arvore[a].x+d
				arvore[i].y=y
				game:insert( arvore[i] )
			end
		end	

	end
end

geraArvores(_W,centerY*1.20,7,320)


function geraCanos(x,y,j,d)

	for i=1,j do
		if (i==1) then

			chama[i] = display.newImageRect("imagens/bolamal.png", _W*0.05, _H*0.08)
			chama[i].x = x
			chama[i].y = centerY*1.5
			game:insert(chama[i])

			cano[i] = display.newImageRect( "imagens/cano1.png",_W*0.1,_W*0.15 )
			cano[i].x = x
			cano[i].y= y
			game:insert( cano[i] )
			physics.addBody(cano[i],"static")
		


		else
			local a = i-1
			local path = math.random(2)
			if ( path== 1) then


				chama[i] = display.newImageRect("imagens/bolamal.png", _W*0.05, _H*0.08)
				chama[i].x = chama[a].x + d
				chama[i].y = y
				game:insert(chama[i])
				physics.addBody(chama[i],"static")
				--chama[i].myName="bomba"

				cano[i] = display.newImageRect( "imagens/cano1.png",_W*0.1,_W*0.15 )
				cano[i].x = cano[a].x+d
				cano[i].y= y
				game:insert( cano[i] )
				--physics.addBody(cano[i],"kinematic")

			else
				chama[i] = display.newImageRect("imagens/bolamal.png", _W*0.05, _H*0.08)
				chama[i].x = chama[a].x + d
				chama[i].y = y
				game:insert(chama[i])
				physics.addBody(chama[i],"static")
				--chama[i].myName="bomba"

				cano[i] = display.newImageRect( "imagens/cano2.png",_W*0.1,_W*0.15 )
				cano[i].x = cano[a].x+d
				cano[i].y= y
				game:insert( cano[i] )
				physics.addBody(cano[i],"kinematic")
				

			

			end
		end	

	end
end


geraCanos(centerX+_W*3, centerY*1.55,3,_W*1.2 )
cano[2].myName="cano2"
cano[3].myName="cano3"


timer.performWithDelay( 1000,function ()
	transition.to(chama[1], {time =1300, y = 0, onComplete = function()
   	transition.from(chama[1], {time = 1500, y = _H-60})
  end})
end
, -1 )

timer.performWithDelay( 1000,function ()
	transition.to(chama[2], {time =1300, y = 0, onComplete = function()
   	transition.from(chama[2], {time = 1500, y = _H-60})
  end})
end
, -1 )

timer.performWithDelay( 1000,function ()
	transition.to(chama[3], {time =1300, y = 0, onComplete = function()
   	transition.from(chama[3], {time = 1500, y = _H-60})
  end})
end
, -1 )

local bolamal = display.newImageRect("imagens/bolamal.png", _H*0.085, _H*0.085)
bolamal.x = cano[2].x+50
bolamal.y = cano[2].y
game:insert(bolamal)
physics.addBody(bolamal,"static",{bounce=1})
bolamal.myName="bolamal"


 --timer.performWithDelay(1000, function ( )  transition.to(bolamal, {time = 2000, x=cano[3].x, onComplete =}) end)



function geraMoedasDiagonalEsquerda(x,y,j)

for i=1,j do
	if(i==1)then
		moeda[i] = display.newImageRect( "imagens/ouro.png",_W*0.06,_H*0.08  )
		moeda[i].x = x
		moeda[i].y = y
		game:insert(moeda[i])
		physics.addBody(moeda[i], "static" )
		moeda[i].isSensor=true
		moeda[i].myName="moeda"
			else 
				local a = i-1
				moeda[i] = display.newImageRect( "imagens/ouro.png",_W*0.06,_H*0.08  )
				moeda[i].x = moeda[a].x + 50
				moeda[i].y = moeda[a].y - 20
				game:insert(moeda[i])
				physics.addBody(moeda[i], "static" )
				moeda[i].isSensor=true
				moeda[i].myName="moeda"
	end
end
end
function geraMoedasDiagonalDireita(x,y,j)

for i=1,j do
	if(i==1)then
		moeda[i] = display.newImageRect( "imagens/ouro.png",_W*0.06,_H*0.08  )
		moeda[i].x = x
		moeda[i].y = y
		game:insert(moeda[i])
		physics.addBody(moeda[i], "static" )
		moeda[i].isSensor=true
		moeda[i].myName="moeda"
			else 
				local a = i-1
				moeda[i] = display.newImageRect( "imagens/ouro.png",_W*0.06,_H*0.08  )
				moeda[i].x = moeda[a].x + 50
				moeda[i].y = moeda[a].y + 20
				game:insert(moeda[i])
				physics.addBody(moeda[i], "static" )
				moeda[i].isSensor=true
				moeda[i].myName="moeda"
	end
end
end

function geraMoedas(x,y,j)

for i=1,j do
	if(i==1)then
		moeda[i] = display.newImageRect( "imagens/ouro.png",_W*0.06,_H*0.08  )
		moeda[i].x = x
		moeda[i].y = y
		game:insert(moeda[i])
		physics.addBody(moeda[i], "static" )
		moeda[i].isSensor=true
		moeda[i].myName="moeda"
			else 
				local a = i-1
				moeda[i] = display.newImageRect( "imagens/ouro.png",_W*0.06,_H*0.08  )
				moeda[i].x = moeda[a].x + 50
				moeda[i].y = moeda[a].y
				game:insert(moeda[i])
				physics.addBody(moeda[i], "static" )
				moeda[i].isSensor=true
				moeda[i].myName="moeda"
	end
end
end
geraMoedas(centerX*0.3, centerY*1.3,10)
geraMoedas(centerX*0.35, centerY*1.1,9)

game:insert(moedas)

--j[quantidade de bombas], d[distancia entre uma e outra]
function geraBomba( x,y,j,d)
	-- body
	for i=1,j do
		if(i==1)then
			 bomba[i] = display.newImageRect("imagens/bomba.png",_W*0.08, _H*0.1 )
			 bomba[i].x = x
			 bomba[i].y = y
			 game:insert(bomba[i])
			 physics.addBody( bomba[i], "static" )
			 bomba[i].myName="bomba"
				else 
					local a = i-1
					 bomba[i] = display.newImageRect("imagens/bomba.png",_W*0.08, _H*0.1 )
					 bomba[i].x = bomba[a].x+d
					 bomba[i].y = bomba[a].y
					 game:insert(bomba[i])
					 physics.addBody( bomba[i], "static" )
			 		bomba[i].myName="bomba"
		end
	end
	
end


player = display.newImageRect( "imagens/bola.png", _H * 0.085, _H * 0.085)
player.x =centerX * 0.2
player.y = centerY * 1.5
physics.addBody( player, 'dynamic', { radius = 15,friction = 0.2, density=0.01,  bounce=0.5} )
game:insert(player)
player.myName = "bola"


borderLeft = display.newRect( 0, centerY, 1,_H )
borderLeft:setFillColor( 0,0,0,0 )
physics.addBody(borderLeft,"static" )
game:insert(borderLeft)



plataforma[1] = display.newImageRect( "imagens/ground.png",_W*0.50,_H*0.15 )
plataforma[1].x = centerX + _W
plataforma[1].y = centerY*1.2
game:insert(plataforma[1])
physics.addBody(plataforma[1], "kinematic", {bounce=0.5})
plataforma[1].isPlataform=true
plataforma[1].myName = "ground"


plataforma[2] = display.newImageRect( "imagens/ground.png",_W*0.50,_H*0.15 )
plataforma[2].x = plataforma[1].x + 340
plataforma[2].y = centerY*0.7
game:insert(plataforma[2])
physics.addBody(plataforma[2], "kinematic", {bounce=0.5})
plataforma[2].isPlataform=true
plataforma[2].myName = "ground"

geraMoedas(plataforma[2].x-130,plataforma[2].y-50,5)
geraMoedas(plataforma[2].x-130,plataforma[2].y-70,5)


plataforma[3] = display.newImageRect( "imagens/ground.png",_W*0.50,_H*0.15 )
plataforma[3].x = plataforma[2].x + 350
plataforma[3].y = centerY*0.7
game:insert(plataforma[3])
physics.addBody(plataforma[3], "kinematic", {bounce=0.5})
plataforma[3].isPlataform=true
plataforma[3].myName = "ground"

geraMoedas(plataforma[3].x-100,plataforma[3].y-50,5)
geraMoedas(plataforma[3].x-100,plataforma[3].y-70,5)



plataforma[4] = display.newImageRect( "imagens/ground.png",_W*0.50,_H*0.15 )
plataforma[4].x = plataforma[3].x + 350
plataforma[4].y = centerY*1.2
game:insert(plataforma[4])
physics.addBody(plataforma[4], "kinematic", {bounce=0.5})
plataforma[4].isPlataform=true
plataforma[4].myName = "ground"

geraMoedas(plataforma[4].x-100,plataforma[4].y-50,5)
geraMoedas(plataforma[4].x-100,plataforma[4].y-70,5)



superGround[1] = display.newImageRect("imagens/groundx4.png", _W*0.4,_H*0.3)
superGround[1].x = _W*7
superGround[1].y = centerY*1.4
game:insert(superGround[1])
physics.addBody(superGround[1],"kinematic")


geraMoedas(superGround[1].x*0.7,centerY*1.3,15)




local anel= display.newImageRect("imagens/anelzao.png", _W*0.2,_W*0.2)
anel.x = _W*7
anel.y = centerY*0.8
game:insert(anel)
physics.addBody(anel,"kinematic")
anel.isSensor=true
anel.myName="anel"

 geraBomba(plataforma[1].x*1.6,centerY*1.5,3,150)
 bomba[2].x=bomba[1].x+100 
 bomba[2].y = centerY
 bomba[3].x = bomba[2].x+100
 geraMoedasDiagonalEsquerda(bomba[1].x-50,centerY*1.35,2)
 geraMoedasDiagonalEsquerda(moeda[2].x+50, centerY*1.4,2)
 geraMoedasDiagonalEsquerda(moeda[2].x+50, centerY*1.4,2)




 
-- tries e coins

barra = display.newImageRect( "imagens/barrasuperior.png",_W,_H*0.08)
barra.x = centerX
barra.y = centerY*0.1
cena:insert(barra)

live[1] = display.newImageRect("imagens/live.png", _W*0.05, _H*0.06)
live[1].x = centerX * 1.5
live[1].y = centerY*0.1 
live[1]:setFillColor(1,0,0)
cena:insert(live[1])



live[2] = display.newImageRect("imagens/live.png", _W*0.05, _H*0.06)
live[2].x = centerX * 1.65
live[2].y = centerY*0.1 
live[2]:setFillColor(1,0,0)
cena:insert(live[2])



live[3] = display.newImageRect("imagens/live.png", _W*0.05, _H*0.06)
live[3].x = centerX * 1.8
live[3].y = centerY*0.1 
live[3]:setFillColor(1,0,0)
cena:insert(live[3])


nummoedas = 0
showmoeda = display.newImageRect( "imagens/moedas.png",_W*0.05,_H*0.08)
showmoeda.x = centerX*0.2
showmoeda.y = centerY*0.10
cena:insert(showmoeda)


moedabar = display.newImageRect("imagens/livebar.png", _W*0.1,_H*0.06)
moedabar.x = showmoeda.x + 40
moedabar.y = showmoeda.y 
moedabar:setFillColor(1,1,0)
cena:insert(moedabar)


nummoedasText = display.newText( ""..nummoedas, showmoeda.x+30,showmoeda.y,fonte , 12 )
--nummoedasText = display.newText( ""..nummoedas, centerX*0.2,centerY*0.1, nil, 20 )
nummoedasText:setFillColor(1,1,1)
cena:insert(nummoedasText)


 -- bomba[2] = display.newImageRect("imagens/bomba.png",_W*0.08, _H*0.1 )
 -- bomba[2].x = plataforma[1].x*1.6
 -- bomba[2].y = centerY*1.5
 -- game:insert(bomba[i])
 -- physics.addBody( bomba[i], "static" )
 -- bomba[i].myName="bomba"

-- chama = display.newImageRect("imagens/chama.png", _W*0.05, _H*0.08)
-- chama.x = bomba[1].x * 1.3
-- chama.y = centerY*1.5
-- game:insert(chama)
-- physics.addBody(chama,"kinematic")
-- chama.myName="bomba"


-- cano[1] = display.newImageRect("imagens/cano.png", _W*0.15, _H*0.2)
-- cano[1].x = bomba[1].x * 1.3
-- cano[1].y = centerY*1.5
-- game:insert(cano[1])
-- physics.addBody(cano[1],"kinematic")


-- timer.performWithDelay( 1000,function ()
-- 	transition.to(chama, {time =1300, y = 0, onComplete = function()
--    	transition.from(chama, {time = 1500, y = _H-60})
--   end})
-- end
-- , -1 )

--timer.performWithDelay(1000, function() bomba[i].rotation = bomba[i].rotation + 6; end, 0)
local function moveCamera()
	if (player.x == nil) then
		print("nil")
		else if( player.x > 80 and player.x < 3000) then
			game.x = -player.x + 80
		end
	end
end


-->>>>>>>>>>>>>>>>>>>>>>>
--require("tries&coins")

-->>>>>>>>>>>>>>>>>>>>>>>

local back = widget.newButton
{
    width =_W*0.1,
    height = _H*0.07,
    defaultFile = "imagens/back.png",
    overFile = "imagens/back2.png",
    --label = "button",
    onEvent = handleButtonEvent
}

-- Center the button
back.x = centerX*0.2
back.y = centerY*1.8


cena:insert(1, game)

cena:insert(3,back)

-- timer.performWithDelay( 3000,function ()
-- 	transition.to(bomba[i], {time =1300, y = 0, onComplete = function()
--    	transition.to(bomba[i], {time = 1500, y = centerY})
--   end})
-- end
-- , -1 )
group:insert(cena)


Runtime:addEventListener( "collision", onBombaCollision )
Runtime:addEventListener("collision", onmoedaCollision)
Runtime:addEventListener("collision", onGroundCollision)
Runtime:addEventListener( "enterFrame", moveCamera )
Runtime:addEventListener( 'tap', screen_tap )
muteSoundsIcon:addEventListener("tap", mute)
Runtime:addEventListener("collision",onAnelCollision)


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
--storyboard:removeScene(storyboard.getCurrentSceneName())
Runtime:removeEventListener( "collision", onBombaCollision )
Runtime:removeEventListener("collision", onmoedaCollision)
Runtime:removeEventListener("collision", onGroundCollision)
Runtime:removeEventListener( "enterFrame", moveCamera )
Runtime:removeEventListener( 'tap', screen_tap )
muteSoundsIcon:removeEventListener("tap", mute)
Runtime:removeEventListener("collision",onAnelCollision)


-----------------------------------------------------------------------------

--      INSERT code here (e.g. sbaseBorda timers, remove listeners, unload sounds, etc.)

-----------------------------------------------------------------------------

end

function scene:overlayBegan( event )
	local group = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
	
	Runtime:removeEventListener( "collision", onBombaCollision )
	Runtime:removeEventListener("collision", onmoedaCollision)
	Runtime:removeEventListener("collision", onGroundCollision)
	Runtime:removeEventListener( "enterFrame", moveCamera )
	Runtime:removeEventListener( 'tap', screen_tap )
	Runtime:removeEventListener("collision",onAnelCollision)


	-----------------------------------------------------------------------------

	--      This event requires build 2012.797 or later.

	-----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
	local group = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
		
	Runtime:addEventListener( "collision", onBombaCollision )
	Runtime:addEventListener("collision", onmoedaCollision)
	Runtime:addEventListener("collision", onGroundCollision)
	Runtime:addEventListener( "enterFrame", moveCamera )
	Runtime:addEventListener( 'tap', screen_tap )
	Runtime:addEventListener("collision",onAnelCollision)

	
	
    --storyboard.reloadScene()
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

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().


---------------------------------------------------------------------------------

return scene



