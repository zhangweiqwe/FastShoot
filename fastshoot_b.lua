
local shootKey = 1
local fastShootKey = 5




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
               	PressAndReleaseMouseButton(1)
               	Sleep(22)
	         		OutputLogMessage("shoot\n")
               	until not IsMouseButtonPressed(fastShootKey)
	

			end
		end

end
