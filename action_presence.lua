return {
   active = true,
   on = {
	devices = {
		'Presence',
--		'Mamie',
--		28
	},
	timer = {
                'at sunset',
		'at civiltwilightend',
		'20 min after civiltwilightend',
		'at 07:20 on mon,tue,wed,thu,fri',
        }
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Action Presence"
   },

--   data = {
--        bPassCivilNight = { initial = false }
--   },
   execute = function(domoticz, device)

	local maison = domoticz.groups(2)
	local salon = domoticz.groups(4) --domoticz.devices(7)
	local sapin = domoticz.devices(29)
        local mamie = domoticz.devices(31)
        local presence = domoticz.devices(27)
	local isNoel = domoticz.devices(95)
--	local guiralnde_ext01 = domoticz.devices(94)
        local filter = { 'Guirlande' , 'Guirlande_ext01' }
        local guirlandes = domoticz.devices().filter(filter)

        if (device.isDevice) then
		if (device.active and domoticz.time.isCivilNightTime and mamie.active == false) then
                        if(salon.state == 'Off') then 
				salon.switchOn()
	                        salon.devices().forEach(function(device)
        	                        if(device.active == false) then
                	                        device.setLevel(50)
                        	        end
	                        end)
			end
--			sapin.switchOn().checkFirst()
			domoticz.notify('Presence changed' , 'Vous êtes revenus ! #Joie',domoticz.PRIORITY_NORMAL,domoticz.NSS_PUSHBULLET)
		elseif (device.active == false and mamie.active == false) then
			maison.switchOff()
                	domoticz.notify('Presence changed' , 'Plus personne à la maison.',domoticz.PRIORITY_NORMAL,domoticz.NSS_PUSHBULLET)
	                domoticz.triggerIFTTT("CLOSE_STORE")
--		else
--                        salon.switchOn().checkFirst()
--                        salon.devices().forEach(function(device)
--                                if(device.levelVal == 50) then
--                                        device.setLevel(100)
--                                end
--                        end)
		end
	end
        if (device.isTimer) then
		if (domoticz.time.matchesRule('at sunset') and (presence.active or mamie.active)) then
--			sapin.switchOn().checkFirst()
                        if(salon.state == 'Off') then 
				salon.switchOn()
	                        salon.devices().forEach(function(device)
        	                        if(device.active == false) then
                	                        device.setLevel(50)
                        	        end
	                        end)
        	                domoticz.notify('Timer lumiere' , 'Au sunset',domoticz.PRIORITY_NORMAL,domoticz.NSS_PUSHBULLET)
			end
			if (isNoel.active and presence.active) then
        	                guirlandes.forEach(function(device)
	                                device.switchOn()
                	        end)
			end
		elseif (domoticz.time.matchesRule('at civiltwilightend') and (presence.active or mamie.active) and salon.state == 'On') then 
--                        salon.switchOn().checkFirst()
                        salon.devices().forEach(function(device)
                                if(device.levelVal == 50) then
                                        device.setLevel(100)
                                end
                        end)
--                        sapin.switchOn().checkFirst()
--		elseif (domoticz.time.matchesRule('at 07:20 on mon,tue,wed,thu,fri in week 51') and (presence.active or mamie.active)) then
		end
	end
   end
}

