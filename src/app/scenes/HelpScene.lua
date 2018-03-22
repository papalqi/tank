
local HelpScene = class("HelpScene", function()
    return display.newScene("HelpScene")
end)

function HelpScene:ctor()
    -- 背景图片
    local sharedDirector = cc.Director:getInstance()
	local winSize = sharedDirector:getWinSize()
    display.newSprite("main_bg.jpg")
		:pos(display.cx,display.cy)
		:addTo(self)
	display.newSprite("select_tank_content.png")
		:pos(display.cx,display.cy)
		:addTo(self)
 
	--cc.drawLine(cc.p(0,300), cc.p(300,300),cc.c4b(255, 0, 0, 255))
	local imageFmat = ".png"
	local canonRoad = "tank/head"
	local armorRoad = "tank/body"
	local wheelRoad = "tank/trackwheel"
	local index = 2

	Tank = import("app/scenes/tank")

	local tank = Tank.new(wheelRoad..index..imageFmat,armorRoad..index..imageFmat,canonRoad..index..imageFmat,index)
	tank:setTag(1)
	tank:setPosition(230,display.cy+20)
	tank:setScale(2,2)

	tank:addTo(self)

	local switchToLeft = cc.ui.UIPushButton.new("Button/left.png",{scale9 = true})
	local switchToRight = cc.ui.UIPushButton.new("Button/right.png",{scale9 = true})
	local Back = cc.ui.UIPushButton.new("Button/back.png",{scale9 = true})
	switchToLeft:addTo(self)
	switchToLeft:setPosition(80,display.cy+20)
	switchToRight:addTo(self)
	switchToRight:setPosition(380,display.cy+20)
	local tankType = cc.ui.UILabel.new({
		UILabelType=2,
		text="英雄："..index,
		size = 32
		})
	tankType:align(display.CENTER,180,display.cy+160)
	tankType:setTag(2)
	tankType:addTo(self)


	switchToLeft:onButtonClicked(function(event)
		if index >1 then 
			index = index -1
		else
			index = 6
		end
		self:getChildByTag(2):setString("英雄："..index)
		self:removeChildByTag(1)
		local tank = Tank.new(wheelRoad..index..imageFmat,armorRoad..index..imageFmat,canonRoad..index..imageFmat,index)
		tank:setPosition(230,display.cy+20)
		tank:setScale(2,2)
		tank:setTag(1)
		tank:addTo(self)
	end)

	switchToRight:onButtonClicked(function(event)
		if index <6 then 
			index = index + 1
		else
			index = 1
		end
		self:getChildByTag(2):setString("英雄："..index)
		self:removeChildByTag(1)
		local tank = Tank.new(wheelRoad..index..imageFmat,armorRoad..index..imageFmat,canonRoad..index..imageFmat,index)
		tank:setPosition(230,display.cy+20)
		tank:setScale(2,2)
		tank:setTag(1)
		tank:addTo(self)
	end)


	-- local shape = display.newLine({{0, 300}, {1000,300}},
	-- 	{borderColor = cc.c4f(0.1, 0.1, 0.1, 1.0),
	-- 	borderWidth = 10})
	
	-- 	shape:addTo(self)

	local tankHP = cc.ui.UILabel.new({
		UILabelType=2,
		text="当前血量点：",
		size = 32
		})
	tankHP:align(display.CENTER,display.cx+150,display.cy+100)
	tankHP:setTag(2)
	tankHP:addTo(self)

	local tankHurt = cc.ui.UILabel.new({
		UILabelType=2,
		text="当前伤害值：",
		size = 32
		})
	tankHurt:align(display.CENTER,display.cx+150,display.cy+20)
	tankHurt:setTag(3)
	tankHurt:addTo(self)

	local tankSpeed = cc.ui.UILabel.new({
		UILabelType=2,
		text="当前伤害值：",
		size = 32
		})
	tankSpeed:align(display.CENTER,display.cx+150,display.cy-50)
	tankSpeed:setTag(4)
	tankSpeed:addTo(self)

	local backImages = {normal = "/Button/back.png"}
	local backButton = cc.ui.UIPushButton.new(backImages, {scale9 = true})
	 	:setScale(0.6,0.6)
	 	:onButtonClicked( function (event)
	 		local scene = import("app.scenes.MenuScene"):new()
	 		display.replaceScene(scene, "moveInL", 0.5)
	 	end)
	 	:align(display.CENTER, 60,60)
	 	:addTo(self)


	-- local fakeLayer = display.newColorLayer(cc.c4b(0,255,0,0))
	-- fakeLayer:setTouchEnabled(true)
	-- fakeLayer:setPosition(130,display.cy-80)
	-- fakeLayer:setContentSize(200,200)
	-- fakeLayer:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	-- fakeLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
 --    	if event.name == "began" then
 --    		local skillScene = import("app.scenes.SkillScene"):new()
 --    		display.replaceScene(skillScene, "moveInR", 0.5)
 --    		return true
 --    	end
 --    end)
	-- fakeLayer:addTo(self)


end

function HelpScene:onEnter()
end

function HelpScene:onExit()
end

return HelpScene
