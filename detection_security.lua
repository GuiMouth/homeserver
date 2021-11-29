return {
   active = true,
   on = {
	devices = {
--		82,
--		38,
		'Motion*',
	},
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Action Security"
   },

   execute = function(domoticz, device)

	local securityIssue = domoticz.variables(17)
        local alarm = domoticz.devices('dz_sec_panel')

        if (device.isDevice and alarm.state == domoticz.SECURITY_ARMEDAWAY) then
		if (device.active) then
			if(securityIssue.lastUpdate.minutesAgo > 4) then 
				securityIssue.set(tostring(device.id))
			end 
		end
	end
   end
}

