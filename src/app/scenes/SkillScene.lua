
local SkillScene = class("SkillScene", function()
	local scene = display.newScene("SkillScene")
    return scene
end)

function SkillScene:ctor(index1, index2)
   -- 背景图片
   	local scaleNum = 1.4
    local sharedDirector = cc.Director:getInstance()
	local winSize = sharedDirector:getWinSize()
	local bg_sprite = cc.Sprite:create("background/bg_skill.png")
		:pos(display.cx,display.cy)
		:setScale(1.7,1.72)
		:addTo(self)

 	local mission = index1 
 	local tank = index2

	local backImages= {
		normal = "Button/back_normal.png",
		pressed = "Button/back_pressed.png"
	}

	local Back = cc.ui.UIPushButton.new(backImages,{scale9 = true})
		:setScale(1.8,1.8)
	 	:onButtonClicked( function (event)
	 		local scene = import("app.scenes.MenuScene").new(mission, tank)
	 		display.replaceScene(scene, "moveInL", 0.5)
	 	end)
	 	:align(display.CENTER, 50,display.cy*2 - 50)
	 	:addTo(self)

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

	self:setText(tank)	

	local bigTank = cc.Sprite:create(bigRoad..tank..PngForm)
		:setTag(1)
		:pos(330,display.cy-80)
		:setScale(scaleNum,scaleNum)
		:addTo(self)

	local smallTank = cc.Sprite:create(smallRoad..tank..PngForm)
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
			if tank >1 then 
				tank = tank - 1
			else
				tank = 3
			end
			self:removeChildByTag(1)
			self:removeChildByTag(2)
			local bigTank = cc.Sprite:create(bigRoad..tank..PngForm)
				:setTag(1)
				:pos(330,display.cy-80)
				:setScale(scaleNum,scaleNum)
				:addTo(self)
			local smallTank = cc.Sprite:create(smallRoad..tank..PngForm)
				:setTag(2)
				:setScale(scaleNum,scaleNum)
				:pos(120,display.cy*2-220)
				:addTo(self)

			self:removeChildByTag(10)
			self:setText(tank)			

	 	end)
	 	:setPosition(50,display.cy-80)
	 	:addTo(self)

	local toRight = cc.ui.UIPushButton.new(rightImages,{scale9 = true})
		:setScale(1.4,1.4)
	 	:onButtonClicked( function (event)
			if tank <3 then 
				tank = tank + 1
			else
				tank = 1
			end
			self:removeChildByTag(1)
			self:removeChildByTag(2)
			local bigTank = cc.Sprite:create(bigRoad..tank..PngForm)
				:setTag(1)
				:pos(330,display.cy-80)
				:setScale(scaleNum,scaleNum)
				:addTo(self)
			local smallTank = cc.Sprite:create(smallRoad..tank..PngForm)
				:setTag(2)
				:setScale(scaleNum,scaleNum)
				:pos(120,display.cy*2-220)
				:addTo(self)

			self:removeChildByTag(10)
			self:setText(tank)	
	 	end)
	 	:setPosition(display.cx*2 - 50,display.cy-80)
	 	:addTo(self)

end



function SkillScene:onEnter()
end

function SkillScene:onExit()
end

function SkillScene:setText(ind)
	local text1 = "前苏联主战坦克\n".."拿着焚寂剑杀光所有坦克"
	local text2 = "美国主战坦克\n".."拿着诛仙剑黑光所有人"
	local text3 = "德国主战坦克\n".."拿着轩辕剑哈哈哈"
	local textTable={text1, text2, text3}
	cc.ui.UILabel.new({
		UILabelType = 2,
		text = textTable[ind],
		size = 32
	})
	:align(display.CENTER, display.width - 320,display.cy-50)
	:setTag(10)
	:addTo(self)	
end

return SkillScene
