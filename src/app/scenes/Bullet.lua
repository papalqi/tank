local Bullet = class("Bullet", function(image) 
	local bullet = display.newSprite("bullet/bullet"..image..".png")
	bullet.dir=1
	bullet.damage=image
	bullet.sound="mp3/sfx_fire2.mp3"
	--bullet.x=t.x
	--bullet.y=t.y
    return bullet 
end)

function Bullet:setDir(dir1)
	rotate=cc.RotateBy:create(0.01,(-self.dir+dir1)*90)
	self:runAction(rotate)
	self.dir=dir1
end


function Bullet:setAction(dir1)
	self:setDir(dir1)
	if(dir1==1)then
		local move=cc.MoveBy:create(50,cc.p(0,20000))
		self:runAction(move)
	elseif(dir1==2)then
		local move=cc.MoveBy:create(50,cc.p(20000,0))
		self:runAction(move)
	elseif(dir1==3)then
		local move=cc.MoveBy:create(50,cc.p(0,-20000))
		self:runAction(move)
	elseif(dir1==4)then
		local move=cc.MoveBy:create(50,cc.p(-20000,0))
		self:runAction(move)
	end
end

function Bullet:setPosition1(x,y,dir1)
	if(dir1==1)then
		self:setPosition(cc.p(x,y+50))
	elseif(dir1==2)then
		self:setPosition(cc.p(x+50,y))
	elseif(dir1==3)then
		self:setPosition(cc.p(x,y-50))
	elseif(dir1==4)then
		self:setPosition(cc.p(x-50,y))
	end
end

function Bullet:checkBullet(object)
	local rect=object:getBoundingBox()
	local pos=cc.p(self:getPosition())
	local isContain=cc.rectContainsPoint(rect,pos)
	if(isContain)then
		return false
	end
	return true
end


function Bullet:checkBound()
	posx=self:getPositionX()
	posy=self:getPositionY()
	if not(posy<display.top and posy>0 and posx>0 and posx<display.right)then
		return true
	end
	return false
end

return Bullet