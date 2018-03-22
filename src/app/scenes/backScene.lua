local backScene = class("backScene", function()

    local layer02 = display.newColorLayer(cc.c4b(107,108,107,180))
    --加game_over对话框
    local sprite02 = display.newSprite("background/game_over.png")
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


    --返回按钮
    cc.ui.UIPushButton.new()
        :onButtonClicked(function(event)
            cc.Director:getInstance():resume()
            scheduler.unscheduleGlobal(handle)
            local scene = import("app.scenes.MenuScene").new(layer02:getParent():getParent():getChildByTag(1).index, layer02:getParent().tankName)
            display.replaceScene(scene, "moveInL", 0.5)
         end)
        :align(display.CENTER, display.cx+200, display.cy - 80)
        :addTo(layer02)
        :setButtonLabel(cc.ui.UILabel.new({
         UILabelType=1,
         text="back",font="font/back_and_continue.fnt",size = 128
        }))

    
    --重玩按钮
    local but_restart = cc.ui.UIPushButton.new()
        :onButtonClicked(function(event)
            cc.Director:getInstance():resume()
            layer02:removeSelf()
        end)
        :addTo(layer02)
        :align(display.CENTER, display.cx+200, display.cy)
        :setButtonLabel(cc.ui.UILabel.new({
         UILabelType=1,
         text="continue",font="font/back_and_continue.fnt",size=128
        }))   
    return layer02
end)
function backScene:ctor()
	
end

return backScene