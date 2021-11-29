return {
        active = true,
        on = {
                timer = { 'at 15:11'
                },
        },
 logging = {
  level = domoticz.LOG_ERROR,
  marker = "Conchito every day"
 },


        execute = function(dz, item)
		local filterIdx = {
			60, -- numeroBis
			15 -- Conchito
		}
		local allDevices = dz.devices().filter(filterIdx)
                local presence = dz.devices(27)
		if(not presence.active) then
--			dz.utils.osExecute('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e speak:\'Préparez-vous ! Je vous rappelle que dans 5 minutes il sera temps dapplaudir !\'')
                        allDevices.forEach(function(device)
		--		domoticz.log("Device idx : " .. tostring(device.idx))
                              if (device.id == 15) then
                                      device.setLevel(10)
                              elseif(device.id == 60) then
                                      device.setLevel(50)
                              end
                      end)
		elseif(presence.active) then
			allDevices.forEach(function(device)
				if (device.id == 15) then
					device.setLevel(10)
				end
			end)
		end
	end
}
