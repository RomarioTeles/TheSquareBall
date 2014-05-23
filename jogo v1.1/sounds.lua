local _W = display.contentWidth
local  _H = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local widget = require( "widget" )

 coins = audio.loadSound("sons/pickupGold.wav")
 hurt = audio.loadSound( "sons/hurt.wav" )
 jump = audio.loadSound( "sons/jump.wav" )
 music = audio.loadStream("sons/trilha.mp3")

 audio.play(music)

muteSoundsIcon = display.newImageRect("imagens/somIcone.png",_W*0.08,_H*0.07)
muteSoundsIcon.x = centerX*1.8
muteSoundsIcon.y = centerY*1.8


muteOn = false 

function mute(event)

	if(muteOn == false) then
		muteOn = true
		audio.pause(music)
        else
        	muteOn = false
        	audio.resume(music)

    end

end

muteSoundsIcon:addEventListener("tap", mute)
