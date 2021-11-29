return {
   active = true,
   on = {
	devices = {
		82,
		38,
		93,
	},
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Action Escalier"
   },

   execute = function(domoticz, device)

	local couloir = domoticz.devices(41)
        local alarm = domoticz.devices('dz_sec_panel')
	local escalier_2eme = domoticz.devices(57)
	local motion_bas = domoticz.devices(93)
	local escalier_rdc = domoticz.devices(84)

        if (device.isDevice and alarm.state == domoticz.SECURITY_DISARMED) then
                if(device.active and device.id == motion_bas.id and domoticz.time.matchesRule('at nighttime')) then
			escalier_rdc.cancelQueuedCommands()
	                escalier_rdc.switchOn().forSec(30)
                elseif(device.active and not domoticz.time.matchesRule('at nighttime')) then
                        escalier_rdc.cancelQueuedCommands()
                        escalier_rdc.switchOff()
		end
		if (device.active) then
			if(device.id == 38 and domoticz.time.matchesRule('at 10:00-18:00')) then
				escalier_2eme.cancelQueuedCommands()
				escalier_2eme.switchOn().forMin(3)
				escalier_2eme.setLevel(10)
			elseif(domoticz.time.matchesRule('at 18:00-21:00')) then
                                escalier_2eme.cancelQueuedCommands()
                                couloir.cancelQueuedCommands()
                                couloir.switchOn().forMin(2)
                                couloir.setLevel(50)
			elseif(domoticz.time.matchesRule('at 21:00-00:00')) then
                                couloir.cancelQueuedCommands()
                                couloir.switchOn().forMin(2)
                                couloir.setLevel(20)
                        elseif(domoticz.time.matchesRule('at 00:00-06:00')) then
                                couloir.cancelQueuedCommands()
                                couloir.switchOn().forMin(2)
                                couloir.setLevel(1)
                        elseif(domoticz.time.matchesRule('at 06:00-10:00')) then
                                couloir.cancelQueuedCommands()
                                couloir.switchOn().forMin(2)
                                couloir.setLevel(30)
			end
		end
	end
   end
}

