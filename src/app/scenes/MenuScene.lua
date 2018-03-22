
local MenuScene = class("MenuScene", function()
    return display.newScene("MenuScene")
end)

function MenuScene:ctor(missiondex, tandex)

	audio.playMusic("mp3/choose.wav",true)

	local Maxmission = 4
	local scaleNum = 1
	local mission = missiondex
    local sharedDirector = cc.Director:getInstance()
	local winSize = sharedDirector:getWinSize()
	local bg_sprite = cc.Sprite:create("background/bg_skill.png")
		:pos(display.cx,display.cy)
		:setScale(1.7,1.72)
		:addTo(self)

	local backImages= {
		normal = "Button/back_normal.png",
		pressed = "Button/back_pressed.png"
	}
	local Back = cc.ui.UIPushButton.new(backImages,{scale9 = true})
		:setScale(1.8,1.8)
	 	:onButtonClicked( function (event)
	 		local mainScene = import("app.scenes.MainScene"):new()
	 		display.replaceScene(mainScene, "moveInL", 0.5)
	 	end)
	 	:align(display.CENTER, 50,display.cy*2 - 50)
	 	:addTo(self)

	local tankIndex =tandex --目前坦克的序号不能传送的问题依然存在
	local smallRoad = "smallTank/smallTank"
	local bigRoad = "bigTank/bigTank"
	local PngForm = ".png"

	local choose = cc.Sprite:create("background/bg_choose"..PngForm)
		:pos(70,display.cy*2-290)
		:setScale(scaleNum,scaleNum)
		:addTo(self)

	local inform = cc.Sprite:create("background/bg_inform"..PngForm)
		:pos(display.cx*2 - 300,display.cy-50)
		:setScale(1.4,1.4)
		:addTo(self)

	local bigTank = cc.Sprite:create(bigRoad..tankIndex..PngForm)
		:setTag(1)
		:pos(200,display.cy-80)
		:setScale(scaleNum,scaleNum)
		:addTo(self)

	local smallTank = cc.Sprite:create(smallRoad..tankIndex..PngForm)
		:setTag(2)
		:setScale(scaleNum,scaleNum)
		:pos(40,display.cy*2-270)
		:addTo(self)

	local missionImage = cc.Sprite:create("mission/mission"..mission..PngForm)
		:setTag(4)
		:setScale(0.2,0.2)
		:pos(display.cx*2 - 300,display.cy-10)
		:addTo(self)

	local leftImages = {
		normal = "Button/left_arrow1.png",
		pressed = "Button/left_arrow2.png"

	}
	local rightImages = {
		normal = "Button/right_arrow1.png",
		pressed = "Button/right_arrow2.png"

	}
	local toLeft = cc.ui.UIPushButton.new(leftImages,{scale9 = true})
		:setScale(1.4,1.4)
	 	:onButtonClicked( function (event)
	 	if mission > 1 then 
	 		mission = mission -1
		else
	 		mission =Maxmission
		end
	 	self:getChildByTag(3):setString("当前关卡:"..mission)
	 	self:removeChildByTag(4)
		local missionImage = cc.Sprite:create("mission/mission"..mission..PngForm)
			:setTag(4)
			:setScale(0.2,0.2)
			:pos(display.cx*2 - 300,display.cy-10)
			:addTo(self)
	 	end)
	 	:setPosition(display.cx*2 - 560,display.cy-80)
	 	:addTo(self)

	local toRight = cc.ui.UIPushButton.new(rightImages,{scale9 = true})
		:setScale(1.4,1.4)
	 	:onButtonClicked( function (event)
	 		if mission < Maxmission then 
	 			mission = mission +1
	 		else
	 			mission =1
	 		end
	 		self:getChildByTag(3):setString("当前关卡:"..mission)
	 		self:removeChildByTag(4)
			local missionImage = cc.Sprite:create("mission/mission"..mission..PngForm)
				:setTag(4)
				:setScale(0.2,0.2)
				:pos(display.cx*2 - 300,display.cy-10)
				:addTo(self)


	 	end)
	 	:setPosition(display.cx*2 - 40,display.cy-80)
	 	:addTo(self)

	local playImages = {
		normal = "Button/play_normal.png",
		pressed = "Button/play_pressed.png"
	}

	local play = cc.ui.UIPushButton.new(playImages,{scale9 = true})
		:setScale(1.4,1.4)
		:onButtonClicked(function (event)
			audio.stopMusic(false)
			local scene_game = import("app.scenes.GameScene").new(mission,tankIndex)
			display.replaceScene(scene_game, "crossFade", 0.5)

		end)
		:setPosition(display.cx,30)
		:addTo(self)

	local tankHurt = cc.ui.UILabel.new({
		UILabelType=2,
		text="当前关卡:"..mission,
		size = 20
		})
	tankHurt:align(display.CENTER,display.cx*2 - 300,display.cy-100)
	tankHurt:setTag(3)
	tankHurt:addTo(self)



	local fakeLayer = display.newColorLayer(cc.c4b(0,255,0,0))
	fakeLayer:setTouchEnabled(true)
	fakeLayer:setPosition(50,display.cy-230)
	fakeLayer:setContentSize(300,300)
	fakeLayer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	fakeLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
    	if event.name == "began" then
    		local skillScene = import("app.scenes.SkillScene").new(mission,tankIndex)
    		display.replaceScene(skillScene, "moveInR", 0.5)
    		return true
    	end
    end)
	fakeLayer:addTo(self)
end




function MenuScene:onEnter()
end

function MenuScene:onExit()
end

return MenuScene
