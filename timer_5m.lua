return {
        active = true,
        on = {
                timer = { 'every 5 minutes',
                },
        },
	logging = {
		 level = domoticz.LOG_ERROR,
		 marker = "Chauffage Calendar"
},


        execute = function(domoticz, item)
--              local allDevices = domoticz.devices().filter(filterIdx)
--                local presence = domoticz.devices(27)
--                local poele = domoticz.devices(92)
--                local weather_netatmo = domoticz.devices(10)
                local gestionChauffage = domoticz.variables(18)
                if(gestionChauffage.value == "oui") then
                        domoticz.utils.osExecute('/home/guimouth/domoticz/scripts/calendar/chauffage_init.sh chauffage_calendar')
--                        domoticz.notify("Chauffage Calendar", "Chaffage calendar", domoticz.PRIORITY_HIGH, NSS_PUSHBULLET)
                end
        end
}

