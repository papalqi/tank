local Fight = class("Fight", function(type,tankName) 

	local layer=display.newColorLayer(cc.c4b(0,0,0,0))
	Tank=import("app.scenes.Tank")
	Bullet=import("app.scenes.Bullet")
	Prop=import("app.scenes.Prop")
	layer.type=1
	layer.Herotable={}
	layer.TankPos={0,0,0,0}--敌方坦克table
	layer.BulletPos=0--我方坦克的子弹--一个变量
	layer.BulletEnemy={0,0,0,0}--敌方坦克的子弹
	layer.prop=0-------------道具
	layer.place=type----------场景
	layer.tankName=tankName
	layer.TankNum=20
	layer.Tankcount=0

	layer.curScore=0
	layer.highScore=cc.UserDefault:getInstance():getIntegerForKey("HighScore")
	layer.heroLife = 3

	return layer
end)


function Fight:octr()
	math.newrandomseed()
end


function Fight:produceTank(image,posx,posy)
	local tank=Tank.new(image,2,1,5)
	tank:setPosition(posx,posy)
	tank:addTo(self)
	return tank
end

function Fight:initFight()

	self:randPropLocation()
	tankHero=self:produceTank(self.tankName,300,50)
	table.insert(self.Herotable,tankHero)
	--产生敌人坦克
	local t1 = math.random(4,6)
	local t2 = math.random(4,6)
	local t3 = math.random(4,6)
	local t4 = math.random(4,6)

	self:sceneBomb()
	--设置分数栏框
	self.highScoreLabel = cc.ui.UILabel.new({UILabelType = 2, text ="最高分:"..self.highScore, color = cc.c3b(200, 0, 0),size=32,})
		:align(display.CENTER, display.cx + 300, display.top - 24)
		:addTo(self)
	self.curScoreLabel = cc.ui.UILabel.new({UILabelType = 2, text = "当前分数:"..self.curScore,color=cc.c3b(200, 0, 0),size=32})
		:align(display.CENTER, display.cx+100, display.top - 24)
        :addTo(self)

    --设置生命值属性
    self.heroLifeLable = cc.ui.UILabel.new({UILabelType = 2, text ="生命:"..(self.heroLife), color = cc.c3b(200, 0, 0),size=32,})
    	:align(display.CENTER,display.cx -300,display.top-24)
    	:addTo(self) 

    --敌方坦克剩余
    self.tankAmountLabel = cc.ui.UILabel.new({UILabelType = 2, text = "敌方剩余:"..(self.TankNum), color = cc.c3b(200, 0, 0), size =32 })
    	:align(display.CENTER, display.cx-150, display.top-24)
    	:addTo(self)


   	dir=display.newSprite("Button/circle.png")
   	dir:setOpacity(150)
	local size2 = display.height/3
	dir:setPosition(cc.p(display.cy/2,display.cy/2))
	dir:setScale(size2/(dir:getContentSize().width), size2/(dir:getContentSize().height))
	dir:setTouchEnabled(true)
	dir:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)

	fireButton=cc.ui.UIPushButton.new("Button/fire.png",{scale9 = true})
		:setOpacity(150)
		:setPosition(cc.p(display.width - display.cy/3,display.cy/3))
		:setScale(0.5,0.5)
		:onButtonClicked(function (event)
			if(self.BulletPos==0)then
				local bullet = self.Herotable[1]:onFire()
				bullet:addTo(self)
				bullet:setAction(self.Herotable[1].dir)
				self.BulletPos=bullet
			end
		end)
		:addTo(self)

	---添加键盘返回键
	self:setKeypadEnabled(true)
    self:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
        if (event.key=="back")then           
            cc.Director:getInstance():pause()
            local playScene = import("app.scenes.backScene").new()
                :addTo(self)
        end   
    end)
   self:onKey()---------------键盘控制方向键

end


function Fight:enemySetfire()
	for i,k in pairs(self.TankPos) do
		if(self.BulletEnemy[i]==0 and k~=0 and self.Herotable[1]~=0 and self.Herotable[1].skill~=6)then
			local bullet1=k:onFire()
			bullet1:setAction(k.dir)
			bullet1:addTo(self)
			self.BulletEnemy[i]=bullet1
		end
	end
end

function Fight:ememyTankMoveAndPause()
	for i,k in pairs(self.TankPos)do
	   	if(k~=0)then
	   		if(self.Herotable[1]~=0 and self.Herotable[1].skill~=6)then
	   			local posx=k:getPositionX()
	   			local posy=k:getPositionY()
	   			local dir2=self:direction(posx,posy,display.width/2,0)
	   			k:setAction(dir2)
	   		else
	   			k:stopAllActions()
	   		end
	   	else
	   		if(self.TankNum>0)then
	   			self.TankPos[i]=self:produceTank(math.random(4,6),self:tankPlant().x,self:tankPlant().y)
	   			self.Tankcount=self.Tankcount+1
	   			self.TankNum=self.TankNum-1
	   			self.tankAmountLabel:setString("敌方剩余:"..(self.TankNum+self.Tankcount))
	   		end
	   	end
	end
	if(self.TankNum<=0 and self.Tankcount<=0)then
		scheduler.unscheduleGlobal(handle)
		cc.UserDefault:getInstance():setIntegerForKey("HighScore", self.highSorce)
	   	local menuScene = import("app.scenes.WinScene").new()
	   		:addTo(self)
	end
end


function Fight:fight_ction()
	
---------
	if(self.Herotable[1]~=0)then
		self.Herotable[1]:scheduleUse()
	end
	self:setFire()

	self:schedule(function()
			self:enemySetfire()

------检测道具生命
		self:checkPropLife()
		if(self.Herotable[1]~=0)then
			self.Herotable[1]:scheduleUse()
		end

	end,0.5)
--------------------------全局调度器
	scheduler=require(cc.PACKAGE_NAME..".scheduler")
	local function onInterval(dt)
		self:ememyTankMoveAndPause()
	end 
	handle = scheduler.scheduleGlobal(onInterval,2)

	local size1=dir:getContentSize()

	-----------帧事件-----------------------
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
		if (self.heroLife >0 and self.Herotable[1]~=0) then 
        	self.Herotable[1]:checkBound()
    	end
        for i,k in pairs(self.TankPos)do
        	if(k~=0)  then
        		 k:checkBound()
        	end
        end
        --坦克之间的检测与障碍物的检测
        --英雄坦克与敌方坦克之间的检测
        for k,e in pairs(self.TankPos)do
        	if(e~=0  and self.Herotable[1]~=0)then
        		self.Herotable[1]:checkTank(e)
        		e:checkTank(self.Herotable[1])
        	end
        end

        for k,e in pairs(self.TankPos)do
        	for k1,e1 in pairs(self.TankPos)do
        		if(k~=k1 and e~=0 and e1~=0)then
        			e:checkTank(e1)
        		end
        	end
        end


		self:enemyBulletCheckTank()
		self:bulletCheckEnemyTank()
		self:blockTanksCheck()------
		self:bulletCheckBlock()------子弹检测障碍物
		self:bulletCheckEnemyBullet()------敌方子弹与我方子弹的检测
		self:tankCheckProp()
		if self.curScore >= self.highScore then
			self.highScore = self.curScore
			self.highScoreLabel:setString("最高分:"..self.highScore)
		end
		-- self:checkProp()


		if(self.BulletPos~=0)then
			if(self.BulletPos:checkBound())then
				self.BulletPos=0
			end
		end
		for k,e in pairs(self.BulletEnemy)do
			if(e~=0)then
				if(e:checkBound())then
					self.BulletEnemy[k]=0
				end
			end 
		end
    end)
    self:scheduleUpdate()

    local layer2=display.newColorLayer(cc.c4b(0,0,0,0))

    dir=display.newSprite("Button/circle.png")
   	dir:setOpacity(150)
   	local size1=dir:getContentSize()
	local size2 = display.height/3
	dir:setPosition(cc.p(display.cy/2,display.cy/2))
	dir:setScale(size2/(dir:getContentSize().width), size2/(dir:getContentSize().height))
    circle=display.newSprite("Button/dir.png")
    circle:setOpacity(200)
	circle:setPosition(cc.p(display.cy/2,display.cy/2))
	local location=display.cy/2
	local r = display.cy/3
	local size = display.height/12
	circle:setScale(size/(circle:getContentSize().width), size/(circle:getContentSize().height))
	layer2:add(dir,2)
	layer2:add(circle,2)	
	layer2:addTo(self)

	local rid=nil
	layer2:setTouchEnabled(true)
	layer2:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
	layer2:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
    	 for id,point in pairs(event.points)do
    	 	
            if(event.name=="began")then
            	--摇杆区域
           		 if(point.x-location<r and point.y-location<r and location-point.x<r and  location-point.y<r)then

           			circle:setPosition(point.x,point.y)
           			if (rid==nil)then
           				rid=id
           			end
           			self.Herotable[1]:Dirupdate(point.x-location,point.y-location,size1.width/2)


           		--发子弹区域
           	   	elseif(point.x>((display.width - display.cy/3)-115) and  point.x<((display.width - display.cy/3)+115) and 
           				point.y>((display.cy/3)-115) and point.y<((display.cy/3)+115))then
           			if(self.BulletPos==0)then
						local bullet=self.Herotable[1]:onFire()
						audio.playSound(bullet.sound)
						bullet:addTo(self)
						bullet:setAction(self.Herotable[1].dir)
						self.BulletPos=bullet
					end	
           		end
           	    return true
         	elseif(event.name=="moved")then
         		for sid,spoint in pairs(event.points)do
         		    if (point.x<display.width-300)then
         				if(sid==rid)then
							self.Herotable[1]:Dirupdate(point.x-location,point.y-location,size1.width*3)
           					local  dis=cc.pGetDistance(cc.p(location,location),cc.p(spoint.x,spoint.y))
           		 			local  rat=50/dis
           		 			local Px=rat*(spoint.x-location)
           		 			local Py=rat*(spoint.y-location)
           		 			circle:setPosition(Px+location,Py+location)
           				end
           			elseif(point.x>((display.width - display.cy/3)-115) and  point.x<((display.width - display.cy/3)+115) and 
           				point.y>((display.cy/3)-115) and point.y<((display.cy/3)+115))then
           				if(self.BulletPos==0)then
							local bullet=self.Herotable[1]:onFire()
							audio.playSound(bullet.sound)
							bullet:addTo(self)
							bullet:setAction(self.Herotable[1].dir)
							self.BulletPos=bullet
						end	
           			end
           		end
   			elseif(event.name=="ended")then
   				circle:setPosition(location,location)
             	self.Herotable[1]:stopAllActions()
   			end
   		end	

		end )
end


function Fight:setFire()

	fireButton:setTouchEnabled(true)
	fireButton:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	fireButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
 		if(event.name=="began")then
           	if(self.BulletPos==0)then
				local bullet=self.Herotable[1]:onFire()
				audio.playSound(bullet.sound)
				bullet:addTo(self)
				bullet:setAction(self.Herotable[1].dir)
				self.BulletPos=bullet
			end	
        	return true
    	end
	end)	
end


function Fight:propCheck()
	if(self.Herotable[1]~=0 and self.prop~=0 and self.Herotable[1]:checkTank(self.prop) )then
		self.Herotable[1]:setBullet()-----道具对坦克的影响
		self.prop:removeSelf()
		self.prop=0
	end
end


function Fight:blockTanksCheck()
---坦克检测障碍物
	 for k,e in pairs(self.place)do
        if(e~=0 and self.heroLife > 0 and self.Herotable[1]~=0)then
        	self.Herotable[1]:checkTankBlock(e)---------------------------该动动检测方式
        end
     end

     for k,e in pairs(self.TankPos)do
        for k1,e1 in pairs(self.place)do
        	if(e~=0 and e1~=0)then
        		e:checkTank(e1)
        	end
        end
     end
end

function Fight:enemyBulletCheckTank()
	  --敌方子弹与我方坦克的碰撞
    for k,e in pairs(self.BulletEnemy)do
        if(e~=0 and self.Herotable[1]~=0)then
        	local flag=e:checkBullet(self.Herotable[1]) 
        	if(not flag)then
        		self.Herotable[1].hp=self.Herotable[1]:decreaseHp(e.damage)
        		self.Herotable[1]:setImage("tank/smallTank_hurt"..self.Herotable[1].num..".png")
        		if(self.Herotable[1].hp<=0)then
					local posx=self.Herotable[1]:getPositionX()
					local posy=self.Herotable[1]:getPositionY()
					self.Herotable[1]:removeSelf()
					self:bomb(posx,posy,1)
					audio.playSound("mp3/sfx_explosiontank.mp3")------音效
					if(self.heroLife > 0) then
        				self.Herotable[1]=self:produceTank(self.tankName,300, 50)
        			else
        				self.Herotable[1]=0
        				scheduler.unscheduleGlobal(handle)
        				cc.Director:getInstance():pause()
						local scene = import("app.scenes.LoseScene").new()
							:addTo(self)
        			end
        			
        		end
        		e:removeSelf()
        		self.BulletEnemy[k]=0
        		break;
        	end
        end
    end
end 


function Fight:bulletCheckEnemyTank()
	    --我方子弹与敌方坦克的碰撞
    local flag=true
    for k1,e1 in pairs(self.TankPos)do
		if(self.BulletPos~=0 and e1~=0)then
			flag=self.BulletPos:checkBullet(e1)	
			if(not flag)then
				e1.hp=e1.hp-self.BulletPos.damage
				e1:setImage("tank/smallTank_hurt"..e1.num..".png")
				if(e1.hp<=0)then
					local posx=e1:getPositionX()
					local posy=e1:getPositionY()
					self:bomb(posx,posy,2)
					e1:removeSelf()
					self.TankPos[k1]=0
					self.Tankcount=self.Tankcount-1
					audio.playSound("mp3/sfx_explosiontank.mp3")-----------爆炸音效
				end
				self.BulletPos:removeSelf()
				self.BulletPos=0;
				audio.playSound("mp3/sfx_explosion.mp3")
				break;
			end	
		end
	end
end


function Fight:bulletCheckEnemyBullet()
	local flag=false;
	for k,e in pairs(self.BulletEnemy)do
		flag=false;
		if(self.BulletPos~=0 and e~=0)then
			local posx1=e:getPositionX()
			local posy1=e:getPositionY()
			local posx=self.BulletPos:getPositionX()
			local posy=self.BulletPos:getPositionY()
		
			if(math.abs(posx-posx1)*2<=20 and math.abs(posy-posy1)*2<40)then
				self.BulletPos:removeSelf()
				self.BulletPos=0
				e:removeSelf()
				self.BulletEnemy[k]=0
				flag=true
			end
		end
		if(flag)then
			break
		end
	end
end


function Fight:bulletCheckBlock()
    local flag=true

    ---------我方子弹与障碍物之间的检测
    for k1,e1 in pairs(self.place)do
		if(self.BulletPos~=0 and e1~=0)then
			flag=self.BulletPos:checkBullet(e1)	
			if(not flag)then
				if e1.hp == 5 then 
        			scheduler.unscheduleGlobal(handle)
        			cc.Director:getInstance():pause()
					local scene = import("app.scenes.LoseScene").new()
						:addTo(self)
				end
				e1.hp=e1.hp-self.BulletPos.damage
				self.BulletPos:removeSelf()
				self.BulletPos=0
				if(e1.hp<0)then
					local type1=e1.type
					local posx=e1:getPositionX()
					local posy=e1:getPositionY()
					self:bomb(posx,posy,0)
					e1:removeSelf()
					self.place[k1]=0
					audio.playSound("mp3/sfx_star.mp3")
					if(type1==1)then
				        self:propProdece(posx, posy)
				    end
				    ---障碍物是否消失
				end
				break;
			end	
		end
	end	
---------敌方子弹与障碍物之间的检测
	for k,e in pairs(self.BulletEnemy)do
        if(e~=0)then
        	for k1,e1 in pairs(self.place)do
        		if(e1~=0)then
        			local flag=e:checkBullet(e1) 
        			if(not flag)then
        				if e1.hp == 5 then 
        					scheduler.unscheduleGlobal(handle)
        					cc.Director:getInstance():pause()
							local scene = import("app.scenes.LoseScene").new()
								:addTo(self)
						end
        				e1.hp=e1.hp-e.damage
        				e:removeSelf()
        				self.BulletEnemy[k]=0
        				if(e1.hp<0)then
        					local type1=e1.type
							local posx=e1:getPositionX()
							local posy=e1:getPositionY()
							self:bomb(posx,posy,0)
							e1:removeSelf()
							self.place[k1]=0
							audio.playSound("mp3/sfx_star.mp3")
				        ---障碍物是否消失

				        -----判断是否产生道具
				        	if(type1==1)then
				        		self:propProdece(posx, posy)
				        	end
						end
						break;
        			end
        		end
        	end
    	end
    end

end



function Fight:checkPropLife()
	if(self.prop~=0 and self.prop~=nil)then
		if(self.prop.life==0)then
			self.prop:removeSelf()
			self.prop=0
		elseif(self.prop.life>0)then
			self.prop.life=self.prop.life-1
			if(self.prop.life<5)then
				self.prop:runAction(cc.Blink:create(1,2))
			end
		 end
	end
end


function Fight:tankCheckProp()
	if(self.prop~=0 and self.Herotable[1]~=0 and self.Herotable[1]:checkTank(self.prop))then
		local flag=self.prop:getTag()
		self.prop:removeSelf()
		self.prop=0
		if(flag==1)then-----
			self.Herotable[1].hp=self.Herotable[1].hp+2 -------具体数值血量
			self.Herotable[1]:setImage("tank/smallTank"..self.Herotable[1].num..".png")
		elseif(flag==2)then
			self.Herotable[1]:setBullet(9)
		elseif(flag==4)then
			self.Herotable[1].life=self.Herotable[1].life+1
			self.heroLifeLable:setString("生命:"..(self.heroLife))
		elseif(flag==5)then
			self.Herotable[1]:increaseSpeed()
		end
		self.Herotable[1].skill=flag
		self.Herotable[1].skillLife=20
	end
end


function Fight:bomb(posx,posy,num)
	if num == 1 then 
		self.heroLife = self .heroLife -1
		self.heroLifeLable:setString("生命:"..(self.heroLife))
	elseif num == 2 or num == 3 then
		if num ==2 then
			self.curScore = self.curScore + 10
		end
		self.curScoreLabel:setString("当前分数:"..self.curScore)
	end

	local pos=cc.p(posx,posy)
	display.addSpriteFrames("animation/bossboom.plist","animation/bossboom.png")
    local frames=display.newFrames("bossboom%d.png",1,4)
    local animation=display.newAnimation(frames,0.1)
    animation:setRestoreOriginalFrame(true)
    local animate =cc.Animate:create(animation)
    local sprite=display.newSprite()
    sprite:ignoreAnchorPointForPosition(false)
    sprite:setPosition(pos)
    		:addTo(self)
    		:runAction(cc.Sequence:create(animate,
 			 	cc.CallFunc:create(function() sprite:removeFromParent() end)))
end


function Fight:randPropLocation()
	i=0;

	while(i<=10)do
		placePos=math.random(1,#self.place)
		if(self.place[placePos].type==0)then
			self.place[placePos].type=1
			i=i+1;
		end
	end
end


function Fight:propProdece(posx,posy)
	i=math.random(1,6)
	if(self.prop==0)then
		self.prop=Prop.new(i)
		self.prop:setPosition(cc.p(posx,posy))
		self.prop:setTag(i)
		self.prop:addTo(self)
	end
end



function Fight:sceneBomb()
	bombSprite=display.newSprite("prop/plane.png")
	bombSprite:setPosition(800,100)
	local size=bombSprite:getContentSize()
	bombSprite:setScale(100/size.width,100/size.height)
	bombSprite:addTo(self)
	bombSprite:setTouchEnabled(true)
	bombSprite:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
	bombSprite:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
 		if(event.name=="began")then
 			local zhuSprite=display.newSprite("prop/plane.png")
 			zhuSprite:ignoreAnchorPointForPosition(false)
 			zhuSprite:setPosition(display.width/2,0)
     		zhuSprite:addTo(self)
     		:runAction(cc.Sequence:create(cc.MoveTo:create(1,cc.p(display.width/2,display.height+400)),
 			  cc.CallFunc:create(function() zhuSprite:removeFromParent() 


           	for k,e in pairs(self.TankPos)do
           		if(e~=0)then
           			local posx=e:getPositionX()
           			local posy=e:getPositionY()
           			e:removeSelf()
           			self:bomb(posx,posy,3)
           			self.TankPos[k]=0
           			audio.playSound("mp3/sfx_explosiontank.mp3")
           			self:bomb(posx,posy,3)-----------------------------------------------------------------------
           		end
           	end
           	 end)))
     		self.Tankcount=0
        	return true
    	end
	end)	
end


function Fight:direction(posx,posy,bossPosx,bossPosy)
	randNum=math.random(1,100)
	if(posy>display.height/2)then--------屏幕一半以上
		if(posx<=bossPosx)then
			if(randNum<=20)then
				return 1
			elseif(randNum>20 and randNum<=50)then
				return 2
			elseif(randNum>50 and randNum<=80)then
				return 3
			else
				return 4
			end
		elseif(posx>bossPosx)then
			if(randNum<=20)then
				return 1
			elseif(randNum>20 and randNum<=40)then
				return 2
			elseif(randNum>40 and randNum<=70)then
				return 3
			else
				return 4
			end
		end

	else                --------------------屏幕一半以下
		if(randNum<=25)then
			return 1
		elseif(randNum>25 and randNum<=50)then
			return 2
		elseif(randNum>50 and randNum<=75)then
			return 3
		else
			return 4
		end	
	end
end

function Fight:tankPlant()
	local table = {{x=25,y=display.cy*2 -25},{x=display.cx,y=display.cy*2 - 25},{x=display.cx*2 -25,y=display.cy*2 -25}}
	local pos = math.random(1,3)
	return table[pos]
end


				
function Fight:onKey()
	self:setKeypadEnabled(true)
	self:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
		if(self.Herotable[1]~=0)then
			if(event.key=="146")then
				self.Herotable[1]:setAction(1)

			elseif(event.key=="127")then
				self.Herotable[1]:setAction(2)
			elseif(event.key=="142")then
				self.Herotable[1]:setAction(3)
			elseif(event.key=="124")then
				self.Herotable[1]:setAction(4)
			elseif(event.key=="59")then
				self.Herotable[1]:stopAllActions()
			elseif(event.key=="133")then
				if(self.BulletPos==0)then
					local bullet=self.Herotable[1]:onFire()
					audio.playSound(bullet.sound)
					bullet:addTo(self)
					bullet:setAction(self.Herotable[1].dir)
					self.BulletPos=bullet
				end	
			end
		end
	end)
end

return Fight