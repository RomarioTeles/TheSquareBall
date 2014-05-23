-- testetststvshbcscj
 _W = display.contentWidth
 _H = display.contentHeight
 centerX = display.contentCenterX
 centerY = display.contentCenterY

local widget = require( "widget" )


display.setStatusBar(display.HiddenStatusBar)

tries = 3
live = {}
fonte=""


if "Win" == system.getInfo( "platformName" ) then 
		fonte = "Anja Eliane" 
	elseif "Android" == system.getInfo( "platformName" ) then 
		fonte = "Anja Heliane" 
	end


barra = display.newImageRect( "imagens/barrasuperior.png",_W,_H*0.08)
barra.x = centerX
barra.y = centerY*0.1

live[1] = display.newImageRect("imagens/live.png", _W*0.05, _H*0.06)
live[1].x = centerX * 1.5
live[1].y = centerY*0.1 
live[1]:setFillColor(1,0,0)



live[2] = display.newImageRect("imagens/live.png", _W*0.05, _H*0.06)
live[2].x = centerX * 1.65
live[2].y = centerY*0.1 
live[2]:setFillColor(1,0,0)


live[3] = display.newImageRect("imagens/live.png", _W*0.05, _H*0.06)
live[3].x = centerX * 1.8
live[3].y = centerY*0.1 
live[3]:setFillColor(1,0,0)


nummoedas = 0
showmoeda = display.newImageRect( "imagens/moedas.png",_W*0.05,_H*0.08)
showmoeda.x = centerX*0.2
showmoeda.y = centerY*0.10

moedabar = display.newImageRect("imagens/livebar.png", _W*0.1,_H*0.06)
moedabar.x = showmoeda.x + 40
moedabar.y = showmoeda.y 
moedabar:setFillColor(1,1,0)

nummoedasText = display.newText( ""..nummoedas, showmoeda.x+30,showmoeda.y,fonte , 12 )
--nummoedasText = display.newText( ""..nummoedas, centerX*0.2,centerY*0.1, nil, 20 )
nummoedasText:setFillColor(1,1,1)


function mountGameOverDisplay( )
	gameOver = display.newImageRect("imagens/score.png", _W*0.5, _H*0.7)
	gameOver.x = centerX
	gameOver.y = centerY

	chooiceIcon = display.newImageRect("imagens/selecaodecenaicon.png", _W*0.1, _W*0.1)
	chooiceIcon.x = centerX*0.87
	chooiceIcon.y=centerY*1.5

	restartIcon = display.newImageRect("imagens/restartcena.png", _W*0.1, _W*0.1)
	restartIcon.x = chooiceIcon.x + 60
	restartIcon.y=centerY*1.5

	scoreText = display.newText(""..nummoedas, centerX,centerY*1.135, fonte, 25)
	scoreText:setFillColor(0,0,0)
	
end

function mountScoreDisplay( )
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
	
end


