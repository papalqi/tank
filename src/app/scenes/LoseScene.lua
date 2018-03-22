--
-- Author: wangxin
-- Date: 2016 - 08 - 27 13: 56: 14
--
local loseScene = class("loseScene", function()
	return display.newScene("loseScene")
end)

function loseScene:ctor()
	--加半透明灰色层
    local layer02 = display.newColorLayer(cc.c4b(107,108,107,180))

	--加game_over对话框
    local sprite02 = display.newSprite("background/game_over.png")
    local scalX1 = (display.width*0.4)/(sprite02:getContentSize().width)-0.4
    local scalY1= (display.height*0.6)/(sprite02:getContentSize().height)
    sprite02:setScaleX(scalX1)
    sprite02:setScaleY(scalY1)
    sprite02:setPosition(display.cx-100, display.cy)
    sprite02:addTo(layer02)

    local move1 = cc.MoveBy:create(1, cc.p(0, 20))
    local move2 = cc.MoveBy:create(1, cc.p(0, -20))
    local SequenceAction = cc.Sequence:create(move1, move2)
    transition.execute(sprite02, cc.RepeatForever:create(SequenceAction))


    --返回按钮
    cc.ui.UIPushButton.new()
        :onButtonClicked(function(event)
            cc.Director:getInstance():resume()
            local scene = import("app.scenes.MenuScene").new(self:getParent():getParent():getChildByTag(1).index, self:getParent().tankName)
	 		display.replaceScene(scene, "moveInL", 0.5)
         end)
        :align(display.CENTER, display.cx+200, display.cy - 80)
        :addTo(layer02)
        :setButtonLabel(cc.ui.UILabel.new({
        	UILabelType=1,
        	text="back",font="font/gameover3.fnt",size = 128
        }))

    
    --重玩按钮
    local but_restart = cc.ui.UIPushButton.new()
        :onButtonClicked(function(event)
            cc.Director:getInstance():resume()
            local secondScene=import("app.scenes.GameScene").new(self:getParent():getParent():getChildByTag(1).index, self:getParent().tankName)
            display.replaceScene(secondScene, "crossFade", 0.5)
        end)
        :addTo(layer02)
        :align(display.CENTER, display.cx+200, display.cy)
        :setButtonLabel(cc.ui.UILabel.new({
        	UILabelType=1,
        	text="restart",font="font/gameover3.fnt",
        }))   
    layer02:addTo(self)
end

return loseScene