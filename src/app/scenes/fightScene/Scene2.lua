--
-- Author: xiaojun
-- Date: 2016-08-26 10:06:47
--

local Scene2 = class("Scene2",function()
	--加载精灵表单
	display.addSpriteFrames("fightScene/scene.plist","fightScene/scene.png")
	local layer =cc.LayerColor:create(cc.c4b(0,0,0,255))
	layer.index = 2
	return layer
end)

	function Scene2:ctor()
	local sharedDirector = cc.Director:getInstance()
	local winSize = sharedDirector:getWinSize()
	local sizeW = 60--设置建筑的标准大小
	local sizeG = 80
	local xnum = winSize.width/sizeW 
	local ynum = winSize.height/sizeW
	local maxX = math.ceil(xnum)
	local maxY = math.ceil(ynum)
	print(winSize.width,winSize.height)
	print(maxX,maxY)

	--画出背景图
	for i =1,ynum+5,1 do
		for j = 1,xnum+5,1 do
			local sprite =import("app.place").new("background/3.png",sizeG,1)
				:setPosition((j-1)*sizeG+sizeG/2,(i-1)*(sizeG-5)+sizeG/2)
				:addTo(self)
		end
	end
	-- local sprite1 = cc.Sprite:create("background/8.png")
	-- 	:setScale(3,3)
	-- 	:addTo(self)
	-- for i = 1,xnum,1 do
	-- 	local sprite =import("app.place").new("#house2.png",sizeW,1)
	-- 			:setPosition((i-1)*sizeW+sizeW/2,1*sizeW+sizeW/2)
	-- 			:addTo(self)
	-- end
	local house3 = {cc.p(2,maxY-5),cc.p(2,maxY-4),cc.p(2,maxY-3),cc.p(2,maxY-2),cc.p(2,maxY-1),
		cc.p(maxX-1,maxY-5),cc.p(maxX-1,maxY-4),cc.p(maxX-1,maxY-3),cc.p(maxX-1,maxY-2),cc.p(maxX-1,maxY-1)}
	local house2 ={cc.p(4,maxY-3),cc.p(5,maxY-3),cc.p(6,maxY-3),cc.p(7,maxY-3),
		cc.p(8,maxY-3),cc.p(9,maxY-3),cc.p(10,maxY-3),cc.p(11,maxY-3),
		cc.p(4,maxY-2),cc.p(5,maxY-2),cc.p(6,maxY-2),cc.p(7,maxY-2),
		cc.p(8,maxY-2),cc.p(9,maxY-2),cc.p(10,maxY-2),cc.p(11,maxY-2),
		cc.p(7,1),cc.p(9,1),cc.p(7,2),cc.p(8,2),cc.p(9,2)}

	local desk = {cc.p(6,maxY-6),cc.p(7,maxY-6),cc.p(8,maxY-6),cc.p(9,maxY-6),cc.p(10,maxY-6)}
	local tower = {
		cc.p(maxX-3,maxY-4),cc.p(maxX-3,maxY-3),
		cc.p(2,2),cc.p(3,2),cc.p(2,3),cc.p(3,3),
		cc.p(maxX-3,maxY-1),cc.p(maxX-4,maxY-1),
		cc.p(maxX-3,maxY),cc.p(maxX-4,maxY),}

	local stone2 = {
		cc.p(11,1),
		-- cc.p(4,maxY-1),cc.p(5,maxY-1),
		cc.p(maxX-3,maxY-2),cc.p(maxX-4,maxY-2),
		cc.p(maxX-4,maxY-4),cc.p(maxX-4,maxY-3),
		cc.p(2,4),cc.p(3,4),cc.p(4,4),cc.p(4,5),cc.p(2,1),
		cc.p(maxX,4),cc.p(maxX-1,4),cc.p(maxX-2,4),cc.p(maxX-3,4),cc.p(maxX-4,4)}

	local stone = {cc.p(6,maxY-5),cc.p(7,maxY-5),cc.p(8,maxY-5),cc.p(9,maxY-5),
		cc.p(6,3),cc.p(7,3),cc.p(8,3),cc.p(9,3)}
	local vat = {cc.p(8,1)}

	local tab1 = self:placeCreate(house3, "#house3.png", sizeW, 1)
	local tab2 = self:placeCreate(house2, "#house2.png", sizeW, 1)
	local tab3 = self:placeCreate(tower, "#tower.png", sizeW, 1)
	local tab4 = self:placeCreate(desk, "#desk.png", sizeW, 1)	
	local tab5 = self:placeCreate(stone, "#stone.png", sizeW, 1000)
	local tab6 = self:placeCreate(stone2, "#stone2.png", sizeW, 1000)
	local tab7 = self:placeCreate(vat, "#vat.png", sizeW, 5)

	local t = {tab1, tab2, tab3, tab4, tab5, tab6, tab7}
	for k,v in pairs(t) do 
		for i,j in pairs(v) do
				table.insert(spriteTable_Scene2,j)
		end
	end
end


function Scene2:placeCreate(myTable,placePath, placeSize, placeHp)
	local tab = {}
	for i,v in pairs(myTable) do
		local sprite = import("app.place").new(placePath, placeSize, placeHp)
			:setPosition((v.x-1)*placeSize+placeSize/2, (v.y-1)*placeSize+placeSize/2)
			:addTo(self)
		table.insert(tab, sprite)
	end
	return tab
end

return Scene2