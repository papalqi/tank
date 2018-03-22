--
-- Author: wangxin
-- Date: 2016 - 08 - 24 09: 51: 44
--

local Scene3 = class("Scene3", function()
	--加载精灵表单
	display.addSpriteFrames("fightScene/scene1.plist","fightScene/scene1.png")
	local layer = cc.LayerColor:create(cc.c4b(0,0,0,255))
    layer.index = 3
	return layer
end)


function Scene3:ctor()

	--背景
	local size = 80
	for i = 1, math.ceil(display.width/size)+5, 1 do
		for j = 1, math.ceil(display.height/size)+5, 1 do
			local sprite = import("app.place").new("fightScene/scene1_bg.png",size,1)
				:setPosition((i-1)*size+size/2, (j-1)*size+size/2)
				:addTo(self)
		end
	end

	local size1 = 60
	local maxX = display.width/size1
	local maxY = display.height/size1

	--街道
	local temx = {maxX-4, maxX-5}
	for i,v in pairs(temx) do
		for j = 1, maxY+5, 1 do
			local sprite = import("app.place").new("fightScene/scene1_stret.png",size1,1)
				:setPosition((v-1)*size1+size1/2, (j-1)*size1+size1/2)
				:addTo(self)
		end
	end

	-- 基地
	local vatTable = {cc.p(8,1)}
	local tab1 = self:placeCreate(vatTable, "fightScene/vat.png", size1, 5)
	
	--tree
	local treeTable = {cc.p(2,1), cc.p(2,2), cc.p(3,1), cc.p(3,2), cc.p(3,3),
		cc.p(4,4), cc.p(6,maxY-2), cc.p(6,maxY-3), cc.p(8,maxY-3), cc.p(9,maxY),
		cc.p(maxX-1,maxY)}
	local tab2 = self:placeCreate(treeTable, "#scene1_tree.png", size1, 1)
		
	--仙人掌
	local plantTable = {cc.p(maxX, 5), cc.p(maxX-1, 5), cc.p(maxX-1,6),
		cc.p(maxX-2,6), cc.p(maxX-2,7), cc.p(maxX-3,7), cc.p(maxX-7,4),
        cc.p(3,6),cc.p(4,7),cc.p(5,7),cc.p(6,7),cc.p(1,3)}
	local tab3 = self:placeCreate(plantTable, "#scene1_xianrenzhang.png", size1, 1000)

	-- greenBox
	local boxTable1 = {cc.p(4,2), cc.p(4,3), cc.p(5,4), cc.p(6,3), cc.p(maxX-5,3),
		cc.p(maxX-4,2), cc.p(maxX-4,7), cc.p(maxX-4,maxY), cc.p(maxX-5,maxY-1),
		cc.p(maxX, 6)}
	local tab4 = self:placeCreate(boxTable1, "#scene1_giftbox_green.png", size1, 1)

	--redBox
	local boxTable2 = {cc.p(2,maxY), cc.p(maxX-5,7), cc.p(maxX-5,maxY), cc.p(maxX-5,2),
		cc.p(5,3), cc.p(maxX-2,3), cc.p(1,maxY-3),cc.p(7,1),cc.p(9,1),cc.p(7,2),cc.p(8,2),cc.p(9,2)}----------
	local tab5 = self:placeCreate(boxTable2, "#scene1_giftbox_red.png", size1, 1)

	--orangeBox
	local boxTable3 = {cc.p(1,maxY), cc.p(3,maxY-3), cc.p(4,maxY-2), cc.p(maxX,7),
		cc.p(maxX-1,3)}
	local tab6 = self:placeCreate(boxTable3, "#scene1_giftbox_orange.png", size1, 1)
	
	--box
	local boxTable4 = {cc.p(1,maxY-5), cc.p(3,maxY-2)}
	local tab7 = self:placeCreate(boxTable4, "#scene_box.png", size1, 1)
	
	--box_damage
	-- local boxTable5 = {cc.p()}

    --scene1_plant
    local scene1_plant = { cc.p(maxX-7,5), cc.p(maxX-8,4),
         cc.p(maxX-6,4), cc.p(maxX-7,3),cc.p(2,6),cc.p(3,5),cc.p(4,6),
            cc.p(maxX-6,9),cc.p(maxX-7,9),cc.p(maxX-5,8)}
    local tab8 = self:placeCreate(scene1_plant, "#scene1_plant.png", size1, 1000)

    --greenhouse
    local greenhouse = {cc.p(maxX-7,8)}
    local tab9 = self:placeCreate(greenhouse, "#scene1_house_green.png", size1, 1)

    local scene1_house_blue = {cc.p(maxX-6,8),cc.p(maxX-8,9),cc.p(maxX-7,7)}
    local tab10 = self:placeCreate(scene1_house_blue, "#scene1_house_blue.png", size1, 1)
	
    local t = {tab1, tab2, tab3, tab4, tab5, tab6, tab7, tab8, tab9, tab10}
    for i,v in pairs(t) do
        for k,e in pairs(v) do
            table.insert(spriteTable_Scene3,e)
        end
    end

    print(#spriteTable_Scene3)
	
end


function Scene3:placeCreate(myTable,placePath, placeSize, placeHp)
	local tab = {}
	for i,v in pairs(myTable) do
		local sprite = import("app.place").new(placePath, placeSize, placeHp)
			:setPosition((v.x-1)*placeSize+placeSize/2, (v.y-1)*placeSize+placeSize/2)
			:addTo(self)
		table.insert(tab,sprite)
	end
	return tab
end

function Scene3:onEnter()
end

function Scene3:onExit()
end

return Scene3