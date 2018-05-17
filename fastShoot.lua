--提高枪械在点射状态下的速度

--提示 须在游戏中修改射击默认按键



--基准射击间隔
local baseShootIntervalTime = 42
--基准射击随机间隔表
local baseShootRandomIntervalTimes = {2,3,-3,-4}
--基准射击随机间隔
local baseShootRandomIntervalTime = baseShootRandomIntervalTimes[table.maxn(baseShootRandomIntervalTimes)]
--改变基准射击随机间隔键
local changeBaseShootRandomIntervalTimeKey = 4


--游戏中配置的射击按键
local realShootKey = "pause"
--射击按键,鼠标左键
local shootKey = 1
local startKey = 5
local finishKey = 6
--开始结束标志
local state = false


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
     	ReleaseMouseButton(shootKey)
     elseif(event == "MOUSE_BUTTON_PRESSED") then
     	if( arg == shootKey) then
	     	if(state) then
               	repeat
               	PressAndReleaseKey(realShootKey)
               	realShootIntervalTime = baseShootIntervalTime+getShootRandomIntervalTime()
               	Sleep(realShootIntervalTime)
	         		OutputLogMessage("realShootIntervalTime = %d", realShootIntervalTime)
               	until not IsMouseButtonPressed(shootKey)
			else
				PressKey(realShootKey)
         			repeat
         	     	Sleep(30)
         			until not IsMouseButtonPressed(shootKey)
				ReleaseKey(realShootKey)
          	end
		elseif(arg == changeBaseShootRandomIntervalTimeKey) then
	     	changeShootRandomIntervalTime()
			OutputLogMessage("baseShootRandomIntervalTime = %d\n",baseShootRandomIntervalTime)
		elseif(arg == finishKey) then
	     	state = false
		elseif(arg == startKey)then
			state = true
		end	
		
         
	 
        end



   

end
