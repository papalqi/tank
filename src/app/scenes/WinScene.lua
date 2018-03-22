local WinScene = class("WinScene", function()
    return display.newScene("WinScene")
end)

function WinScene:ctor()
    --加半透明灰色层
    local layer02 = display.newColorLayer(cc.c4b(107,108,107,120))
    layer02:addTo(self)

    --加game_over对话框
    local vic_lable=cc.ui.UILabel.new({
        UILabelType=1,
        text="victory",font="font/victory.fnt",
        size=80
        })
    vic_lable:setPosition(display.cx-(vic_lable:getContentSize().width/2),display.height-60)
    vic_lable:addTo(layer02)
    local sprite02 = display.newSprite("background/victory.png")
    local scalX1 = (display.width*0.4)/(sprite02:getContentSize().width)-0.4
    local scalY1= (display.height*0.6)/(sprite02:getContentSize().height)
    sprite02:setScaleX(scalX1)
    sprite02:setScaleY(scalY1)
    sprite02:setPosition(display.cx-100, display.cy)
    sprite02:addTo(layer02)

    local move1 = cc.MoveBy:create(1, cc.p(0, 10))
    local move2 = cc.MoveBy:create(1, cc.p(0, -10))
    local SequenceAction = cc.Sequence:create(move1, move2)
    transition.execute(sprite02, cc.RepeatForever:create(SequenceAction))

    --next 场景
    local but_restart = cc.ui.UIPushButton.new()
        :onButtonClicked(function(event)
            local secondScene=import("app.scenes.GameScene").new((self:getParent():getParent():getChildByTag(1).index)%4+1, self:getParent().tankName)
            display.replaceScene(secondScene, "crossFade", 0.5)
        end)
        :addTo(layer02)
        :align(display.CENTER, display.cx+150, display.cy)
        :setButtonLabel(cc.ui.UILabel.new({
        UILabelType=1,
        text="next",font="font/next_and_ok.fnt",
        }))   
    
    --返回按钮
    cc.ui.UIPushButton.new()
        :onButtonClicked(function(event)
            local scene = import("app.scenes.MenuScene").new(self:getParent():getParent():getChildByTag(1).index, self:getParent().tankName)
	 		display.replaceScene(scene, "moveInL", 0.5)
         end)
        :align(display.CENTER, display.cx+150, display.cy - 90)
        :addTo(layer02)
        :setButtonLabel(cc.ui.UILabel.new({
        UILabelType=1,
        text="ok",font="font/next_and_ok.fnt",
        }))	
end



function WinScene:onEnter()
end

function WinScene:onExit()
end

return WinScene