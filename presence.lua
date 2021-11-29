return {
   active = true,
   on = {
	devices = {
		64,
		65,
		81
	},
        customEvents =
        {
            'presence_delayed',
        },
    },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Presence.lua"
   },

   execute = function(domoticz, device)

	local presence = domoticz.devices(27)
	local gui = domoticz.devices(64)
	local astrid = domoticz.devices(65)
        local mamie = domoticz.devices(31)
        local candice = domoticz.devices(81)
        local alarm = domoticz.devices('dz_sec_panel')


        if (device.isDevice) then
		if (device.active) then
			presence.switchOn().checkFirst()
        		local name = domoticz.utils.stringSplit(device.name, " ")
			domoticz.notify(name[2] .. ' home' , name[2] .. ' est revenu(e) ! #Joie',domoticz.PRIORITY_NORMAL,domoticz.NSS_PUSHBULLET)
			alarm.disarm()
		elseif(device.active == false) then
                        local name = domoticz.utils.stringSplit(device.name, " ")
                        domoticz.notify(name[2] .. ' away' , name[2] .. ' est parti(e) ! #Tristesse',domoticz.PRIORITY_NORMAL,domoticz.NSS_PUSHBULLET)
			if (candice.active == false and gui.active == false and astrid.active == false and mamie.active == false) then
				presence.switchOff().checkFirst()
	                	domoticz.notify('Presence changed' , 'Plus personne à la maison.',domoticz.PRIORITY_NORMAL,domoticz.NSS_PUSHBULLET)
				domoticz.emitEvent('presence_delayed').afterMin(60)
			end
		end
	elseif(device.isCustomEvent) then
		if(not presence.active and presence.lastUpdate.minutesAgo > 58 and alarm.state == domoticz.SECURITY_DISARMED) then
			alarm.armAway()
			domoticz.log('ALARM ARMEDAWAY')
		end
		domoticz.log('CUstom Event')
	end
   end
}
