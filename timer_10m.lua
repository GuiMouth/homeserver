return {
        active = true,
        on = {
                timer = { 'every 10 minutes between 9:40 and 16:20 on mon,tue,thu,fri',
                },
        },
	logging = {
		 level = domoticz.LOG_ERROR,
		 marker = "Gestion du chauffage"
},


        execute = function(domoticz, item)
--              local allDevices = domoticz.devices().filter(filterIdx)
                local presence = domoticz.devices(27)
                local poele = domoticz.devices(92)
                local weather_netatmo = domoticz.devices(10)
                local gestionChauffage = domoticz.variables(18)
		local temp_chauffage = domoticz.variables(19)
		local temp_ext = domoticz.devices(44)
		local temp_allumage_poele = domoticz.variables(20)

                if(presence.active and poele.active and weather_netatmo.temperature > temp_chauffage.value + 0.1  and gestionChauffage.value == "oui" and temp_ext.temperature > 5 ) then
                        domoticz.utils.osExecute('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e automation:"EteindrePoele"')
                        domoticz.notify("Extinction du poele", "Extinction du poele", domoticz.PRIORITY_HIGH, NSS_PUSHBULLET)
                elseif(presence.active and poele.active and weather_netatmo.temperature > temp_chauffage.value + 0.3  and gestionChauffage.value == "oui" and temp_ext.temperature < 5) then
                        domoticz.utils.osExecute('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e automation:"EteindrePoele"')
                        domoticz.notify("Extinction du poele", "Extinction du poele", domoticz.PRIORITY_HIGH, NSS_PUSHBULLET)
                elseif(presence.active and not poele.active and weather_netatmo.temperature <= temp_chauffage.value - 0.8 and gestionChauffage.value == "oui") then
                        domoticz.utils.osExecute('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e automation:"AllumerPoele"')
                        domoticz.notify("Allumage du poele", "Allumage du poele", domoticz.PRIORITY_HIGH, NSS_PUSHBULLET)
			temp_allumage_poele.set(weather_netatmo.temperature)
                elseif(presence.active and poele.active and weather_netatmo.temperature <= temp_allumage_poele.value - 0.5 and gestionChauffage.value == "oui" and poele.lastUpdate.minutesAgo >= 20 and poele.lastUpdate.minutesAgo <= 30) then
                        domoticz.utils.osExecute('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e automation:"AllumerPoele"')
                        domoticz.notify("Allumage du poele", "Allumage du poele", domoticz.PRIORITY_HIGH, NSS_PUSHBULLET)
--                elseif(gestionChauffage.value == "oui" and weather_netatmo.temperature < temp_chauffage.value - 0.3) then
--                        domoticz.notify("Poele script", "execute poele script", domoticz.PRIORITY_HIGH, NSS_PUSHBULLET)
--		else
--			domoticz.log('Rien a faire !')
                end
		if(domoticz.time.matchesRule('at 16:20')) then
			poele.switchOff()
		end
        end
}

