
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

	--音乐，音效预加载
	audio.preloadMusic("mp3/1.mp3")
	audio.preloadMusic("mp3/chooseMisson.mp3")
	audio.preloadMusic("mp3/begin.mp3")
	audio.preloadMusic("mp3/bomp.mp3")
	audio.preloadMusic("mp3/music_level_c.mp3")
	audio.preloadMusic("mp3/choose.mp3")

	audio.playMusic("mp3/begin.mp3",true)
    --1.背景图片
	display.newSprite("background/bg_begin.jpg")
		:pos(display.cx,display.cy)
		:setScale(1.6,1.9)
		:addTo(self)

	--开场动画，职业装逼
	local camora = display.newSprite("camora.png")
    	:setScale(1.5,1.5)
        :addTo(self,2)
    local moveTo1 = cc.MoveTo:create(3,cc.p(display.cx*2,0))
    local moveTo2 = cc.MoveTo:create(3,cc.p(display.cx,display.cy*2))
    local moveTo3 = cc.MoveTo:create(2,cc.p(display.cx,display.cy))
    camora:runAction(cc.Sequence:create(moveTo1,moveTo2,moveTo3))

    -- local scheduler = require(cc.PACKAGE_NAME.."scheduler")
	camora:performWithDelay(function ()
		  camora:removeSelf() 
	 end,8.5)

	--2.按钮图片资源
    local SoundCBtnimages = {
        off = "Button/music_off.png",
        off_pressed = "Button/music_off.png",
        on = "Button/music_on.png",
        on_pressed = "Button/music_on.png",
    }

	local continueBtnImages = {
		normal = "Button/continue1.png",
		pressed = "Button/continue2.png",
	}

	local startBtnImages = {
		normal = "Button/new1.png",
		pressed = "Button/new2.png",
	}

	-- 1.声音开关设置Check按钮
	local flag = true
    local checkBoxButton1 = cc.ui.UICheckBoxButton.new(SoundCBtnimages)
        :onButtonStateChanged(function(event) 
            if flag then
            	audio.pauseMusic()
            else audio.resumeMusic()
            end
            flag = not flag
        end)
        :align(display.LEFT_CENTER, display.cx-460, display.cy+270)--设置锚点和位置
        :addTo(self)

	--2.退出游戏按钮
    cc.ui.UIPushButton.new(continueBtnImages, {scale9 = false})
		:onButtonClicked(function(event)
			self:isExit()
		end)
		:align(display.CENTER,display.cx-120, 100)
		:setScale(1.4,1.4)
		:addTo(self)

	-- 3.开始游戏按钮
    cc.ui.UIPushButton.new(startBtnImages, {scale9 = false})
		:onButtonClicked(function(event)
			audio.stopMusic(false) --切换背景音乐，不清除缓冲
			local playScene = import("app.scenes.loadingScene").new()
			display.replaceScene(playScene, "moveInR", 0.5)
		end)
		:align(display.CENTER, display.cx + 120, 100)
		:setScale(1.4,1.4)
		:addTo(self)

	local ring = cc.Sprite:create("background/ring.png")
		:pos(display.cx,100)
		:setScale(1.4,1.4)
		:addTo(self)

	local nameSprite = cc.Sprite:create("background/name.png")
		:pos(display.cx,display.cy+130)
		:setScale(1.1,1.1)
		:addTo(self)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:isExit()
	local  layer = display.newColorLayer(cc.c4b(0,255,0,0))

	local cancleImage = {
		normal = "Button/cancleImage2.png",
		pressed = "Button/cancleImage1.png"
	}

	local confirmImage = {
		normal = "Button/confirmImage2.png",
		pressed = "Button/confirmImage1.png"
	}

	local quit_block = display.newSprite("background/quit_block.png")
		:pos(display.cx,display.cy)
		:addTo(layer)
	local cancle = cc.ui.UIPushButton.new(cancleImage,{scale9 = true})
		:setPosition(display.cx,display.cy -40)
		:onButtonClicked(function (event)
			layer:removeSelf()
		end)
		:addTo(layer)	

	local confirm = cc.ui.UIPushButton.new(confirmImage,{scale9 = true})
		:setPosition(display.cx,display.cy+40)
		:onButtonClicked(function (event)
			cc.Director:getInstance():endToLua()
		end)
		:addTo(layer)
	layer:addTo(self)
end


return MainScene
