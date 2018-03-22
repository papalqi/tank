
local Tank = class("Tank", function(num,hp1,speed1,life1)

	local image = "tank/smallTank"..num..".png"
	local tankSprite=display.newSprite(image)
	local size=tankSprite:getContentSize()
	tankSprite:setScale(50/size.width,50/size.height)
	tankSprite.hp=hp1---血量
	tankSprite.speed=speed1---速度
	tankSprite.dir=1
	tankSprite.skill=0------
	tankSprite.skillLife=0
	tankSprite.life=life1
	tankSprite.num = num 
	tankSprite.BulletType=1

	return tankSprite 
end)

function Tank:setDir(dir1)
	self.dir=dir1
	self:setRotation((dir1-1)*90)
end

function Tank:setAction(dir1)
	self:stopActionByTag(self.dir)
	self:setDir(dir1)
	if(dir1==2)then
		local right_action=cc.MoveBy:create(90,cc.p(10000*self.speed,0))
		right_action:setTag(2)
		self:runAction(right_action)
	elseif(dir1==4)then
		local left_action=cc.MoveBy:create(90,cc.p(-10000*self.speed,0))
		left_action:setTag(4)
		self:runAction(left_action)
	elseif (dir1==1)then
		local up_action=cc.MoveBy:create(90,cc.p(0,10000*self.speed))
		up_action:setTag(1)
		self:runAction(up_action)
	elseif(dir1==3)then
		local down_action=cc.MoveBy:create(100,cc.p(0,-10000*self.speed))
		down_action:setTag(3)
		self:runAction(down_action)
	end
end

function Tank:Dirupdate(x1,y1,size4)

	if(y1<x1 and y1>-x1 and x1+y1<size4 and y1>x1-size4)then
		self:setAction(2)

	elseif(y1<-x1 and y1>x1 and x1+y1>-size4 and y1<x1+size4)then
		self:setAction(4)

	elseif(y1>x1 and y1>-x1 and x1+y1<size4 and y1<x1+size4)then
		self:setAction(1)

	elseif(y1<x1 and y1<-x1 and x1+y1>-size4 and y1>x1-size4)then
		self:setAction(3)
	end
end

function Tank:octr()
	Bullet=import("app.scenes.Bullet")
end


function Tank:scheduleUse()
	if(self.skillLife>0)then
		self.skillLife=self.skillLife-1
	else
		self.skill=0
		self.speed=1
	end
end

function Tank:decreaseHp(damage)
	if(self.skill==3)then
		return self.hp
	end
	return self.hp-damage
end
----增加速度
function Tank:increaseSpeed()
	if(self.skill==5)then
		self.speed=2
	end
end

--------

function Tank:pauseAction()
	if(self.skill==6)then
		tank:stopAllActions()
	end
end


function Tank:checkBound()
	local posx=self:getPositionX()
	local posy=self:getPositionY()
	local size1=20
	if(self.dir==1 and posy>=display.top-size1)then
		self:stopActionByTag(1)
		return true
	elseif(self.dir==2 and posx>=display.right-size1)then
		self:stopActionByTag(2)
		return true
	elseif(self.dir==3 and posy<=size1)then
		self:stopActionByTag(3)
		--self:setAction(1)
		return true
	elseif(self.dir==4 and posx<=size1)then
		self:stopActionByTag(4)
		return true
	end
	return false
end
function Tank:onFire()

	local bullet=Bullet.new(self.BulletType)
	bullet:setPosition1(self:getPositionX(),self:getPositionY(),self.dir)
	return bullet
end


function Tank:setBullet(i)
	self.BulletType=i
end

function Tank:checkTankBlock(object)
	local rect=self:getBoundingBox()
	local rect1=object:getBoundingBox()
	local posx=self:getPositionX()
	local posy=self:getPositionY()
	local posx1=object:getPositionX()
	local posy1=object:getPositionY()
	local flag=false
 if(math.abs(posx-posx1)*2<=(rect1.width+rect.width) and math.abs(posy-posy1)*2<(rect1.height+rect.height))then
		if(self.dir==1 and 2*(posy1-posy)<=(rect.height+rect1.height) 
			and 2*(posy1-posy)>=(rect.height+rect1.height-20)  
			and math.abs(posx-posx1)*2<=(rect1.width+rect.width)-4 )then
			self:stopActionByTag(1)
			if(posx>rect1.width/2+posx1)then
				local action1=cc.MoveBy:create(0.001,cc.p(posx1+rect1.width/2-(posx-rect.width/2),0))
				self:runAction(action1)
				
				self:setAction(1)
			elseif(posx<-rect1.width/2+posx1)then
				self:runAction(cc.MoveBy:create(0.001,cc.p(-(posx+rect.width/2)+(posx1-rect1.width/2),0)))
				self:setAction(1)
			end
		elseif(self.dir==2 and 2*(posx1-posx)<(rect.width+rect1.width) 
			and 2*(posx1-posx)>(rect.width+rect1.width-20)   
			and  math.abs(posy-posy1)*2<(rect1.height+rect.height)-4)then
			self:stopActionByTag(2)
			if(posy>rect1.height/2+posy1)then
				self:runAction(cc.MoveBy:create(0.001,cc.p(0,posy1+rect1.height/2-(posy-rect.height/2))))
				self:setAction(2)
			elseif(posy<-rect1.height/2+posy1)then
				self:runAction(cc.MoveBy:create(0.001,cc.p(0,-(posy+rect.height/2)+(posy1-rect1.height/2))))
				self:setAction(2)
			end
		elseif(self.dir==3 and 2*(posy-posy1)<(rect.height+rect1.height) 
			and 2*(posy-posy1)>(rect.height+rect1.height-20)  
			and math.abs(posx-posx1)*2<=(rect1.width+rect.width)-4)then
			self:stopActionByTag(3)
			if(posx>rect1.width/2+posx1)then
				self:runAction(cc.MoveBy:create(0.001,cc.p(posx1+rect1.width/2-(posx-rect.width/2),0)))
				self:setAction(3)
			elseif(posx<-rect1.width/2+posx1)then
				self:runAction(cc.MoveBy:create(0.001,cc.p(-(posx+rect.width/2)+(posx1-rect1.width/2),0)))
				self:setAction(3)
			end
		elseif(self.dir==4 and  2*(posx-posx1)<(rect.width+rect1.width) 
			and 2*(posx-posx1)>(rect.width+rect1.width-20)   
			and math.abs(posy-posy1)*2<(rect1.height+rect.height)-4 )then
			self:stopActionByTag(4)
			if(posy>rect1.height/2+posy1)then
				self:runAction(cc.MoveBy:create(0.001,cc.p(0,posy1+rect1.height/2-(posy-rect.height/2))))
				self:setAction(4)
			elseif(posy<-rect1.height/2+posy1)then
				self:runAction(cc.MoveBy:create(0.001,cc.p(0,-(posy+rect.height/2)+(posy1-rect1.height/2))))
				self:setAction(4)
			end
		end
	return true
	end
end

function Tank:checkTank(object)
	local rect=self:getBoundingBox()
	local rect1=object:getBoundingBox()
	local posx=self:getPositionX()
	local posy=self:getPositionY()
	local posx1=object:getPositionX()
	local posy1=object:getPositionY()
	local flag=false
	if(math.abs(posx-posx1)*2<=(rect1.width+rect.width) and math.abs(posy-posy1)*2<(rect1.height+rect.height))then
		if(self.dir==1 and 2*(posy1-posy)<=(rect.height+rect1.height) 
			and 2*(posy1-posy)>=(rect.height+rect1.height-20)  
			and math.abs(posx-posx1)*2<=(rect1.width+rect.width)-4 )then
			self:stopActionByTag(1)
	elseif(self.dir==2 and 2*(posx1-posx)<(rect.width+rect1.width) 
			and 2*(posx1-posx)>(rect.width+rect1.width-20)   
			and  math.abs(posy-posy1)*2<(rect1.height+rect.height)-4)then
			self:stopActionByTag(2)
	elseif(self.dir==3 and 2*(posy-posy1)<(rect.height+rect1.height) 
			and 2*(posy-posy1)>(rect.height+rect1.height-20)  
			and math.abs(posx-posx1)*2<=(rect1.width+rect.width)-4)then
			self:stopActionByTag(3)
	elseif(self.dir==4 and  2*(posx-posx1)<(rect.width+rect1.width) 
			and 2*(posx-posx1)>(rect.width+rect1.width-20)   
			and math.abs(posy-posy1)*2<(rect1.height+rect.height)-4 )then
			self:stopActionByTag(4)	
		end	
		return true
	end
end

function  Tank:setImage(str)
	local texture = cc.Director:getInstance():getTextureCache():addImage(str)
	self:setTexture(texture)
	-- body
end

return Tank