
local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor(missondex,tankdex)

    audio.playMusic("mp3/music_level_c.mp3",true)

    -- 背景图片
	spriteTable_Scene1 = {}
	spriteTable_Scene2 = {}
	spriteTable_Scene3 = {}
	spriteTable_Scene4 = {}
    local misson = missondex
    local tank = tankdex
    local layer = import("app.scenes.fightScene.Scene"..misson).new()
    		:setTag(1):addTo(self,1)
 	 local amountTable = {spriteTable_Scene1, spriteTable_Scene2 ,
 	 					  spriteTable_Scene3,spriteTable_Scene4}

 	Fight=import("app.scenes.Fight")
	local fight=Fight.new(amountTable[misson],tank)
	fight:initFight()
	fight:fight_ction()
    fight:setTag(2)
	fight:addTo(self,2)

    local isPlaying =false
    imagesPause={
    on="Button/continue.png",
    off="Button/break.png"
    }
    cc.ui.UICheckBoxButton.new(imagesPause)
    :setPosition(display.width/15+20,display.height*15/16)
    :onButtonStateChanged(function ( event )
        if not isPlaying then
            cc.Director:getInstance():pause()
            isPlaying = true
        else 
            cc.Director:getInstance():resume()
            isPlaying = false
        end
    end)
    :addTo(self,2)

end



function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene
