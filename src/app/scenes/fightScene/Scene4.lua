--
-- Author: wangxin
-- Date: 2016 - 08 - 24 09: 51: 44
--

local Scene4 = class("Scene4", function()
	--加载精灵表单
	display.addSpriteFrames("fightScene/scene1.plist","fightScene/scene1.png")
	local layer = cc.LayerColor:create(cc.c4b(0,0,0,255))
	layer.index = 4
	-- local spriteTable = {}
	--背景
	for i = 1,10,1 do
		for j = 1,15,1 do
			local sprite = import("app.place").new("#scene_bg.png",80,1)
				:setPosition((j-1)*75+40, (i-1)*70+40)
				:addTo(layer)
		end
	end

	--基地
	local home = import("app.place").new("fightScene/wang.png",60,5)
		:setPosition(display.cx, 30)
		:addTo(layer)
	table.insert(spriteTable_Scene4,home)
	local temx = {display.cx-45, display.cx+45}
	for j,v in pairs(temx) do
		local brick1 = import("app.place").new("fightScene/brick_por.png",60,2)
		local scalex = 30/(brick1:getContentSize().width)
		local scaley = 60/(brick1:getContentSize().height)
		brick1:setScale(scalex, scaley)
			:setPosition(v, 30)
			:addTo(layer)
		table.insert(spriteTable_Scene4,brick1)
	end
	local temx1 = {display.cx-30, display.cx+30}
	for i,v in pairs(temx1) do
		local brick = import("app.place").new("fightScene/brick.png",60,2)
		local scalex = 60/(brick:getContentSize().width)
		local scaley = 30/(brick:getContentSize().height)
		brick:setScale(scalex, scaley)
			:setPosition(v, 75)
			:addTo(layer)
		table.insert(spriteTable_Scene4,brick)
	end

	--街道 竖
	local tem1 = {3, 12, 13} --竖街道位置
	for i=1,12,1 do
		for j,v in pairs(tem1) do
			local sprite = import("app.place").new("#scene1_street_portrait.png",60,2)
				:setPosition(v*60+30 , (i-1)*60+30)
				:addTo(layer)
		end
	end
			
	--街道 横
	for i=5,6,1 do
		for j=1,18,1 do
			local sprite = import("app.place").new("#scene1_street_lanscape.png",60,2)
				:setPosition((j-1)*55+30, i*60+30)
				:addTo(layer)
		end
	end

	--街道 路口

	--tree
	local trees = { cc.p(1,5) ,cc.p(2,8), cc.p(3,5),  cc.p(5,5),
				   cc.p(6,8), cc.p(8,5), cc.p(9,5), cc.p(11,1), cc.p(12,5),
				   cc.p(12,8), cc.p(15,5), cc.p(15,8), cc.p(16,8) }

	for i,v in pairs(trees) do
		local sprite = import("app.place").new("#scene1_tree.png", 60, 2)
			:setPosition((v.x-1)*60+30, (v.y-1)*60+30)
			:addTo(layer)
		table.insert(spriteTable_Scene4,sprite)
	end

	--plant
	local plants = {cc.p(6,3)}
	for i,v in pairs(plants) do
		local sprite = import("app.place").new("#scene1_plant.png",60,2)
			:setPosition((v.x-1)*60+30, (v.y-1)*60+30)
			:addTo(layer)
		table.insert(spriteTable_Scene4,sprite)
	end

	--xianrenzhang
	local cactus = {cc.p(16,1)}
	for i,v in pairs(cactus) do
		local sprite = import("app.place").new("#scene1_xianrenzhang.png",60,2)
			:setPosition((v.x-1)*60+30, (v.y-1)*60+30)
			:addTo(layer)
		table.insert(spriteTable_Scene4,sprite)
	end

	--GreenBox
	local spriteBox1 = import("app.place").new("#scene1_giftbox_green.png",60,2)
		:setPosition(6*60+30, 30)
		:addTo(layer)
	print(#spriteTable_Scene4)
	return layer--,spriteTable
end)


function Scene4:placeCreate(myTable,placePath, placeSize, placeHp)
	local tab = {}
	for i,v in pairs(myTable) do
		local sprite = import("app.place").new(placePath, placeSize, placeHp)
			:setPosition((v.x-1)*placeSize+placeSize/2, (v.y-1)*placeSize+placeSize/2)
			:addTo(self)
		table.insert(tab, sprite)
	end
	return tab
end

return Scene4