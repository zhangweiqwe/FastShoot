--提高枪械在点射状态下的速度

--提示 须在游戏中修改射击默认按键



--基准射击间隔
local baseShootIntervalTime = 30
--基准射击随机间隔表
local baseShootRandomIntervalTimes = {2,3,-3,-4}
--基准射击随机间隔
local baseShootRandomIntervalTime = baseShootRandomIntervalTimes[table.maxn(baseShootRandomIntervalTimes)]


--游戏中配置的射击按键
local realShootKey = "pause"
--射击按键,鼠标左键
local shootKey = 1
local fastShootKey = 5
local fastShootAndControlKey = 4
local finishKey = 6

--改变基准射击随机间隔键
local changeShootRandomIntervalTimeKey = 8
--标志
local state = "finish" -- finishKey fastShootKey fastShootAndControlKey


local indexInit = 18
local index = indexInit
local indexB = 0
local baseNumber = 16
local angleMax = 90
local countMax = 48
local baseAngle = math.pi/180
local pressedTime = 0


function getShootRandomIntervalTime()
return math.ceil(math.random()*baseShootRandomIntervalTime)
end


function changeShootRandomIntervalTime()
randomIndex = math.ceil(math.random()*table.maxn(baseShootRandomIntervalTimes))
while(baseShootRandomIntervalTimes[randomIndex]==baseShootRandomIntervalTime) do
randomIndex = math.ceil(math.random()*table.maxn(baseShootRandomIntervalTimes))
end
baseShootRandomIntervalTime = baseShootRandomIntervalTimes[randomIndex]
end






function OnEvent(event, arg)
	OutputLogMessage("event = %s, arg = %s\n", event, arg)
     if (event == "PROFILE_ACTIVATED") then
     	EnablePrimaryMouseButtonEvents(true)
     elseif event == "PROFILE_DEACTIVATED" then
     	ReleaseKey(realShootKey)
     elseif(event == "MOUSE_BUTTON_PRESSED") then
     	ReleaseMouseButton(shootKey)
     	if( arg == shootKey) then
	     	if(state == "fastShootKey") then
               	repeat
               	PressAndReleaseKey(realShootKey)
               	Sleep(realShootIntervalTime)
               	realShootIntervalTime = baseShootIntervalTime+getShootRandomIntervalTime()
	         		OutputLogMessage("realShootIntervalTime = %d", realShootIntervalTime)
               	until not IsMouseButtonPressed(shootKey)
			elseif(state == "fastShootAndControlKey") then





               	repeat


				PressAndReleaseKey(realShootKey)
               	realShootIntervalTime = baseShootIntervalTime+getShootRandomIntervalTime()
				pressedTime = realShootIntervalTime + pressedTime
               	Sleep(realShootIntervalTime)


				
				if(pressedTime>0)then
					pressedTime = 0
					if(index<countMax) then
						index = index + 5
						if(index > countMax)then
						index = countMax
						end
						indexB = index
						--OutputLogMessage("index = %d ",index)
					else
						indexB = index-8
					end
				end
				OutputLogMessage("indexB = %d ",indexB)

					

				x = angleMax/countMax*baseAngle*indexB
				y1 = math.cos(x)
				y0 = baseNumber - math.ceil(y1*baseNumber)
				OutputLogMessage("y1 = %f  y0 = %f\n",y1,y0)


               	


				MoveMouseRelative(0, y0)
				
               	until not IsMouseButtonPressed(shootKey)
				pressedTime = 0
				index = indexInit
			else
				PressKey(realShootKey)
         			repeat
         	     	Sleep(30)
         			until not IsMouseButtonPressed(realShootKey)
				ReleaseKey(realShootKey)
          	end
		elseif(arg == finishKey) then
			state = "finishKey"
		elseif(arg == fastShootKey) then
	     	state = "fastShootKey"
		elseif(arg == fastShootAndControlKey)then
			state = "fastShootAndControlKey"
		elseif(arg == changeShootRandomIntervalTimeKey)then
			--changeShootRandomIntervalTime()
			--OutputLogMessage("baseShootRandomIntervalTime = %d", baseShootRandomIntervalTime)
		end	

	elseif(event == "MOUSE_BUTTON_RELEASED") then
     end



   

end
