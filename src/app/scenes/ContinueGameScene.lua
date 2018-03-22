
local ContinueGameScene = class("ContinueGameScene", function()
    return display.newScene("ContinueGameScene")
end)

function ContinueGameScene:ctor()
    -- 背景图片
   	local scaleNum = 1.4
    local sharedDirector = cc.Director:getInstance()
	local winSize = sharedDirector:getWinSize()
	local bg_sprite = cc.Sprite:create("background/bg_skill.png")
		:pos(display.cx,display.cy)
		:setScale(1.6,1.72)
		:addTo(self)

 
	-- local imageFmat = ".png"
	-- local canonRoad = "tank/head"
	-- local armorRoad = "tank/body"
	-- local wheelRoad = "tank/trackwheel"
	

	-- Tank = import("app/scenes/tank")

	-- local tank = Tank.new(wheelRoad..index..imageFmat,armorRoad..index..imageFmat,canonRoad..index..imageFmat,index)
	-- tank:setTag(1)
	-- tank:setPosition(230,display.cy+20)
	-- tank:setScale(2,2)

	-- tank:addTo(self)

	local backImages= {
		normal = "Button/back_normal.png",
		pressed = "Button/back_pressed.png"
	}

	-- local switchToLeft = cc.ui.UIPushButton.new("Button/left.png",{scale9 = true})
	-- local switchToRight = cc.ui.UIPushButton.new("Button/right.png",{scale9 = true})
	local Back = cc.ui.UIPushButton.new(backImages,{scale9 = true})
		:setScale(1.8,1.8)
	 	:onButtonClicked( function (event)
	 		local scene = import("app.scenes.MenuScene"):new()
	 		display.replaceScene(scene, "moveInL", 0.5)
	 	end)
	 	:align(display.CENTER, 50,display.cy*2 - 50)
	 	:addTo(self)

	-- switchToLeft:addTo(self)
	-- switchToLeft:setPosition(80,display.cy+20)
	-- switchToRight:addTo(self)
	-- switchToRight:setPosition(380,display.cy+20)

	--文字显示部分，显示当前坦克的名称等
	-- local tankType = cc.ui.UILabel.new({
	-- 	UILabelType=2,
	-- 	text="英雄："..index,
	-- 	size = 32
	-- 	})
	-- tankType:align(display.CENTER,210,display.cy+160)
	-- tankType:setTag(2)
	-- tankType:addTo(self)


	-- switchToLeft:onButtonClicked(function(event)
	-- 	if index >1 then 
	-- 		index = index -1
	-- 	else
	-- 		index = 6
	-- 	end
	-- 	self:getChildByTag(2):setString("英雄："..index)
	-- 	self:removeChildByTag(1)
	-- 	local tank = Tank.new(wheelRoad..index..imageFmat,armorRoad..index..imageFmat,canonRoad..index..imageFmat,index)
	-- 	tank:setPosition(230,display.cy+20)
	-- 	tank:setScale(2,2)
	-- 	tank:setTag(1)
	-- 	tank:addTo(self)
	-- end)

	-- switchToRight:onButtonClicked(function(event)
	-- 	if index <6 then 
	-- 		index = index + 1
	-- 	else
	-- 		index = 1
	-- 	end
	-- 	self:getChildByTag(2):setString("英雄："..index)
	-- 	self:removeChildByTag(1)
	-- 	local tank = Tank.new(wheelRoad..index..imageFmat,armorRoad..index..imageFmat,canonRoad..index..imageFmat,index)
	-- 	tank:setPosition(230,display.cy+20)
	-- 	tank:setScale(2,2)
	-- 	tank:setTag(1)
	-- 	tank:addTo(self)
	-- end)


	-- local shape = display.newLine({{0, 300}, {1000,300}},
	-- 	{borderColor = cc.c4f(0.1, 0.1, 0.1, 1.0),
	-- 	borderWidth = 10})
	
	-- 	shape:addTo(self)
	local index = 1 --目前坦克的序号不能传送的问题依然存在
	local smallRoad = "smallTank/smallTank"
	local bigRoad = "bigTank/bigTank"
	local PngForm = ".png"

	local choose = cc.Sprite:create("background/bg_choose"..PngForm)
		:pos(160,display.cy*2-250)
		:setScale(scaleNum,scaleNum)
		:addTo(self)

	local inform = cc.Sprite:create("background/bg_inform"..PngForm)
		:pos(display.cx*2 - 320,display.cy-50)
		:setScale(scaleNum,scaleNum)
		:addTo(self)

	local bigTank = cc.Sprite:create(bigRoad..index..PngForm)
		:setTag(1)
		:pos(330,display.cy-80)
		:setScale(scaleNum,scaleNum)
		:addTo(self)

	local smallTank = cc.Sprite:create(smallRoad..index..PngForm)
		:setTag(2)
		:setScale(scaleNum,scaleNum)
		:pos(120,display.cy*2-220)
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
			if index >1 then 
				index = index - 1
			else
				index = 3
			end
			self:removeChildByTag(1)
			self:removeChildByTag(2)
			local bigTank = cc.Sprite:create(bigRoad..index..PngForm)
				:setTag(1)
				:pos(330,display.cy-80)
				:setScale(scaleNum,scaleNum)
				:addTo(self)
			local smallTank = cc.Sprite:create(smallRoad..index..PngForm)
				:setTag(2)
				:setScale(scaleNum,scaleNum)
				:pos(120,display.cy*2-220)
				:addTo(self)		

	 	end)
	 	:setPosition(50,display.cy-80)
	 	:addTo(self)

	local toRight = cc.ui.UIPushButton.new(rightImages,{scale9 = true})
		:setScale(1.4,1.4)
	 	:onButtonClicked( function (event)
			if index <3 then 
				index = index + 1
			else
				index = 1
			end
			self:removeChildByTag(1)
			self:removeChildByTag(2)
			local bigTank = cc.Sprite:create(bigRoad..index..PngForm)
				:setTag(1)
				:pos(330,display.cy-80)
				:setScale(scaleNum,scaleNum)
				:addTo(self)
			local smallTank = cc.Sprite:create(smallRoad..index..PngForm)
				:setTag(2)
				:setScale(scaleNum,scaleNum)
				:pos(120,display.cy*2-220)
				:addTo(self)	
	 	end)
	 	:setPosition(display.cx*2 - 50,display.cy-80)
	 	:addTo(self)

	local playImages = {
		normal = "Button/next_normal.png",
		pressed = "Button/next_pressed.png"
	}

	local play = cc.ui.UIPushButton.new(playImages,{scale9 = true})
		:setScale(1.4,1.4)
		:onButtonClicked(function (event)
			local scene_game = import("app.scenes.GameScene"):new()
			display.replaceScene(scene_game, "crossFade", 0.5)

		end)
		:setPosition(display.cx,30)
		:addTo(self)




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
end



function ContinueGameScene:onEnter()
end

function ContinueGameScene:onExit()
end

return ContinueGameScene
