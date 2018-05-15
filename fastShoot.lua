--提高枪械在点射状态下的速度



--射击间隔时间
local shootIntervalTime = 0.3

--实际射击按键，此按键和游戏射击按键保持一致，当点击鼠标左键时，通过程序循环点击此按键
local realShootKey = 4

--射击按键
local shootKey = 1

--开始按键
local startKey = 5
--结束按键
local finishKey = 6
--开始结束标志
local stateFlag = "finish"




function OnEvent(event, arg)
	OutputLogMessage("event = %s, arg = %s\n", event, arg)
     if (event == "PROFILE_ACTIVATED") then
       EnablePrimaryMouseButtonEvents(true)
     elseif event == "PROFILE_DEACTIVATED" then
     ReleaseKey(realShootKey)
     ReleaseMouseButton(shootKey)
     end
 

   
     if(stateFlag == "start" and event == "MOUSE_BUTTON_PRESSED" and arg == shootKey) then
     repeat
	OutputLogMessage("event = %s, arg = %s\n", "touch")
       --PressAndReleaseKey(realShootKey)
       Sleep(shootIntervalTime)
     until not IsMouseButtonPressed(shootKey)
     elseif stateFlag == "finish" then
     
     end

     if(event == "MOUSE_BUTTON_PRESSED" and arg == startKey) then
	 stateFlag = 	"start"
	 elseif event == "MOUSE_BUTTON_PRESSED" and arg == finishKey then
      stateFlag = 	"finish"
     end

end
