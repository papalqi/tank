--
-- Author: wangxin
-- Date: 2016 - 08 - 26 09: 25: 43
--
local Scene1 = class("Scene1", function()
	--加载精灵表单
	display.addSpriteFrames("fightScene/scene.plist","fightScene/scene.png")
	local layer = cc.LayerColor:create(cc.c4b(0,0,0,255))
	layer.index = 1
	return layer
end)

function Scene1:ctor()
	
	--背景
	local size = 80
	for i = 1,math.ceil(display.width/size)+5,1 do
		for j = math.ceil(display.height/size)+5, 1, -1 do
			local sprite = import("app.place").new("#ground.png",size,1)
				:setPosition((i-1)*(size-10)+size/2, (j-1)*(size-10)+size/2)
				:addTo(self)	
		end 
	end

	local size1 = 60
	local maxX = display.width/size1
	local maxY = display.height/size1
	--desk
	local deskTable = {}
	for j=7, maxY, 1 do
		table.insert(deskTable, cc.p(2,j))
		table.insert(deskTable, cc.p(maxX-1,j))
	end

	local tab1 = self:placeCreate(deskTable, "#desk.png", size1, 1)

	--stone
	local stoneTable1 = {cc.p(1,1), cc.p(4,1), cc.p(8,7), cc.p(9,7), cc.p(10,7), 
		cc.p(8,8), cc.p(10,8), cc.p(8,9), cc.p(9,9), cc.p(10,9), cc.p(1,5),
		cc.p(2,5), cc.p(3,5), cc.p(4,5), cc.p(5,5), cc.p(6,5), cc.p(6,6), cc.p(6,7),
		cc.p(6,8), cc.p(6,9), cc.p(maxX,5), cc.p(maxX-1,5), cc.p(maxX-2,5), cc.p(maxX-3,5)}
	local tab2 = self:placeCreate(stoneTable1, "#stone2.png", size1, 1000)

	local stoneTable2 = {cc.p(8,5), cc.p(9,5), cc.p(10,5)}
	local tab3 = self:placeCreate(stoneTable2, "#stone.png", size1, 1000)

	--house 
	local house1Table = {cc.p(3,7), cc.p(3,8), cc.p(3,9), cc.p(3,10),
					cc.p(4,7), cc.p(4,10)}
	local tab4 = self:placeCreate(house1Table, "#house1.png", size1, 1)
	local house2Table = {cc.p(1,3), cc.p(2,3), cc.p(3,3), cc.p(4,3), 
					cc.p(maxX,3), cc.p(maxX-1,3), cc.p(maxX-2,3),
					cc.p(maxX-3,3), cc.p(8,3), cc.p(9,3), cc.p(10,3),
					cc.p(8,4), cc.p(9,4), cc.p(10,4)}
	local tab5 = self:placeCreate(house2Table, "#house2.png", size1, 1)
	local house3Table = {cc.p(maxX-2,7), cc.p(maxX-2,8), cc.p(maxX-2,9),
					cc.p(maxX-2,10), cc.p(maxX-3,7), cc.p(maxX-3,10)}
	local tab6 = self:placeCreate(house3Table, "#house3.png", size1, 1)

	--tower
	local towerTable = {cc.p(9,8), cc.p(8,1), cc.p(8,2), cc.p(9,2),
						cc.p(10,2), cc.p(10,1)}
	local tab7 = self:placeCreate(towerTable, "#tower.png", size1, 1)

	--vat
	local vatTable = {cc.p(9,1)}
	local tab8 = self:placeCreate(vatTable, "#vat.png", size1, 5)

	--box 
	local boxTable = {cc.p(1,4), cc.p(maxX,4)}
	local tab9 = self:placeCreate(boxTable, "#box2.png", size1, 1)

	local ttt = {tab1, tab2, tab3, tab4, tab5, tab6, tab7, tab8, tab9}
	for i,v in pairs(ttt) do
		for k,e in pairs(v) do
			table.insert(spriteTable_Scene1,e)
		end
	end
	return spriteTable_Scene1
	
end

function Scene1:placeCreate(myTable,placePath, placeSize, placeHp)
	local tab = {}
	for i,v in pairs(myTable) do
		local sprite = import("app.place").new(placePath, placeSize, placeHp)
			:setPosition((v.x-1)*placeSize+placeSize/2, (v.y-1)*placeSize+placeSize/2)
			:addTo(self)
		table.insert(tab,sprite)
	end
	return tab
end

function Scene1:onEnter()
end

function Scene1:onExit()
end

return Scene1