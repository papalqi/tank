--
-- Author: wangxin
-- Date: 2016 - 08 - 28 15: 41: 26
--

local loadingScene = class("loadingScene", function()

	return display.newScene("loadingScene")
end)

function loadingScene:ctor()

	local layer = cc.LayerColor:create(cc.c4b(0,0,0,0)):addTo(self,2)

    local sprite = display.newSprite("background/bg_begin.jpg")
    local scalex = display.width/sprite:getContentSize().width
    local scaley = display.height/sprite:getContentSize().height
    sprite:setScale(scalex, scaley)
        :pos(display.cx, display.cy)
        :addTo(self,1)

    local height = display.cy - 200
    local width = display.cx
    local loadBar1 = cc.ui.UILoadingBar.new({
        scale9 = true,
        capInsets = cc.rect(0,0,10,10),
        image = "loading/Loading_bg.png",
        viewRect = cc.rect(100,22,200,32),
        percent = 100
    })
    :setScale(1, 1)
    :setPosition(width-100, height-3)
    :addTo(layer,1)

    local percent1 = 25
    local loadBar = cc.ui.UILoadingBar.new({
        scale9 = true,
        capInsets = cc.rect(0,0,10,10),
        image = "loading/Loading.png",
        viewRect = cc.rect(100,22,200,32),
        percent = percent1
    })
    :setScale(1, 1)
    :setPosition(width-100, height-3)
    :addTo(layer,2)

    local lable = cc.ui.UILabel.new({
        UILabelType = 2,
        text = string.format("%d",25).."%",
        size = 32 })
        :align(display.CENTER, width+140, height+10)
        :setTag(1)
        :addTo(layer)
    cc.ui.UILabel.new({
        UILableType = 2,
        text = "loading",
        size = 64
        })
    :align(display.CENTER, display.cx, display.cy)
    :addTo(layer)
    
    self:schedule(function()
        percent1 = percent1 + 25
        loadBar:setPercent(percent1)
        layer:removeChildByTag(1)
        local lable = cc.ui.UILabel.new({
            UILabelType = 2,
            text = string.format("%d",percent1).."%",
            size = 32 })
        :align(display.CENTER, width+140, height+10)
        :setTag(1)
        :addTo(layer)

        if percent1==100 then
            local playScene = import("app.scenes.MenuScene").new(1,1)
            display.replaceScene(playScene, "moveInR", 0.5)
        end
    end, 0.8)
end

 return loadingScene