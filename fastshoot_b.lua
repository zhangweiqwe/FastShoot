
local shootKey = 1
local fastShootKey = 5
local fastShootAndControlKey = 4




local currentAngle
local maxAngle = 90

function OnEvent(event, arg)
	OutputLogMessage("event = %s, arg = %s\n", event, arg)
     if (event == "PROFILE_ACTIVATED") then
     	EnablePrimaryMouseButtonEvents(true)
     elseif event == "PROFILE_DEACTIVATED" then
     	ReleaseMouseButton(shootKey) 
		ReleaseMouseButton(fastShootKey)
     elseif(event == "MOUSE_BUTTON_PRESSED") then
     	
     	if( arg == fastShootKey ) then
               	repeat
               	PressAndReleaseMouseButton(shootKey)
               	Sleep(22)
	         		OutputLogMessage("shoot\n")
               	until not IsMouseButtonPressed(fastShootKey)
		elseif(arg == fastShootAndControlKey)then
				currentAngle = maxAngle
				repeat
				currentAngle = currentAngle-3
				if(currentAngle<10) then
					currentAngle = 10
				end
				x = math.cos(2*math.pi/360*currentAngle)*11
               	PressAndReleaseMouseButton(shootKey)
				MoveMouseRelative(0, x)
               	Sleep(22)
	         		OutputLogMessage("acurrentAngled=%d x=%f\n",currentAngle,x)
               	until not IsMouseButtonPressed(fastShootAndControlKey)
		end
	end

end
