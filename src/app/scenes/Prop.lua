local Prop = class("Prop",function (type)

	
	
	local sprite = cc.Sprite:create("prop/"..type..".png")--设置精灵图片
	sprite.life=20
	
	return sprite
	end)

function Prop:ctor()
	

end



return Prop