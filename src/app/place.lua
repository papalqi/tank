--
-- Author: wangxin
-- Date: 2016 - 08 - 24 16: 42: 57
--

local Place = class("Place", function(path, size, hp1)

	local sprite = display.newSprite(path)
	local scalex = size/sprite:getContentSize().width
	local scaley = size/sprite:getContentSize().height 
	sprite:setScale(scalex, scaley)
	sprite.hp = hp1
	sprite.type = 0
	return sprite
end)

return Place