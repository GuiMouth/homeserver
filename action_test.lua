return {
   active = true,
   on = {
	devices = {
		'Test',
	},
   },
   logging = {
        level = domoticz.LOG_DEBUG,
        marker = "Action Test"
   },

   execute = function(domoticz, device)

	local alarm = domoticz.devices('dz_sec_panel')
	local salon = domoticz.groups(4)
	local gui = domoticz.devices(64)
	local _ = domoticz.utils._
	local salondevice = domoticz.devices(7)
	local weather_netatmo = domoticz.devices(10)
        local conchitoStatus = domoticz.devices(14)
	local temp_ext = domoticz.devices(44)
	local isNoel = domoticz.devices(95)
        local filter = { 'Guirlande' , 'Guirlande_ext01' }
        local guirlandes = domoticz.devices().filter(filter)
	
	if(device.isDevice) then
		if not device.active then
	                if isNoel.active then
        	                guirlandes.forEach(function(device)
					domoticz.log("Device name : " .. device.name)
                	                device.switchOff()
                        	end)
	                end
		end
                guirlandes.forEach(function(device)
	                domoticz.log("Device name : " .. device.name)
                        device.switchOff()
                end)

--	local name = domoticz.utils.stringSplit(gui.name, " ")
--		temp_ext.dump()
--		domoticz.log("Conchito Status : " .. conchitoStatus.rawData[1], domoticz.LOG_INFO)
--		if(device.active == false) then
--		end

--        if (device.isDevice and alarm.state == domoticz.SECURITY_DISARMED) then
--		if (device.active) then
--			alarm.armHome()
--		else
--			alarm.disarm()
--		end
--		domoticz.log("Alarm state : " .. alarm.state, domoticz.LOG_INFO)
--                domoticz.triggerIFTTT("CLOSE_STORE")

	end
   end
}

