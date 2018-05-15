--提高枪械在点射状态下的速度

--提示 须在游戏中修改射击默认按键

--游戏中的射击按键
local realShootKey = "pause"

--基准射击间隔
local baseShootIntervalTime = 22
--基准射击随机间隔表
local baseShootRandomIntervalTimes = {3,4,5,6}
--基准射击随机间隔
local baseShootRandomIntervalTime = baseShootRandomIntervalTimes[table.maxn(baseShootRandomIntervalTimes)]
--改变基准射击随机间隔键
local changeBaseShootRandomIntervalTimeKey = 4


--射击按键,鼠标左键
local shootKey = 1

--开始按键
local startKey = 5
--结束按键
local finishKey = 6
--开始结束标志
local isStart = false


function getShootRandomIntervalTime()
return math.ceil(math.random()*baseShootRandomIntervalTime)
end


function changeShootRandomIntervalTime()

randomIndex = math.ceil(math.random()*table.maxn(baseShootRandomIntervalTimes))

while(baseShootRandomIntervalTimes[randomIndex]==baseShootRandomIntervalTime) do
randomIndex = math.ceil(math.random()*table.maxn(baseShootRandomIntervalTimes))
end
baseShootRandomIntervalTime = baseShootRandomIntervalTimes[randomIndex]


OutputLogMessage("baseShootRandomIntervalTime = %d\n",baseShootRandomIntervalTime)

end




function OnEvent(event, arg)
	OutputLogMessage("event = %s, arg = %s\n", event, arg)
     if (event == "PROFILE_ACTIVATED") then
     	EnablePrimaryMouseButtonEvents(true)
     elseif event == "PROFILE_DEACTIVATED" then
     	ReleaseKey(realShootKey)
     	ReleaseMouseButton(shootKey)
     end
 

if(event == "MOUSE_BUTTON_PRESSED") then

      if(arg == startKey) then
	        isStart = true
	  elseif arg == finishKey then
             isStart = false
       end


		if(arg == changeBaseShootRandomIntervalTimeKey) then
	        changeShootRandomIntervalTime()
		end

         if(isStart) then
               if( arg == shootKey) then
               	repeat
               	PressAndReleaseKey(realShootKey)
               	realShootIntervalTime = baseShootIntervalTime+getShootRandomIntervalTime()
               	Sleep(realShootIntervalTime)
	         		OutputLogMessage("realShootIntervalTime = %d", realShootIntervalTime)
               	until not IsMouseButtonPressed(shootKey)
               end
		else 
		   PressKey(realShootKey)
            repeat
            Sleep(30)
            until not IsMouseButtonPressed(shootKey)
		    ReleaseKey(realShootKey)
          end
	 
end



   

end
