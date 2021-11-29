return {
   active = true,
   on = {
	devices = {
		'Cafetière',
	},
	customEvents =
        {
            'reset',
        },
	variables = {
		15,
	}
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Action Cafetiere"
   },

   execute = function(domoticz, device)

	local priseCafetiere = domoticz.devices(29)
	local isCoffeReady = domoticz.variables(15)

        if (device.isDevice) then
		if (device.active) then
			priseCafetiere.switchOn().forMin(10)
		else
			priseCafetiere.switchOff().checkFirst()
			domoticz.executeShellCommand('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e speak:"Votre café devrait maintenant être prêt !"')
			domoticz.openURL('https://127.0.0.1/json.htm?username=aWZ0dHQ=&password=SWZ0dHRAMjAyMERvbW90aWNaIQ==&type=command&param=cleartimers&idx=39')
		end
	elseif(device.isVariable) then
		if(isCoffeReady.value == "oui") then
			--domoticz.executeShellCommand('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e speak:"OK!"')
		end
	elseif(device.isCustomEvent) then
		local cafetiere = domoticz.devices(39)
		priseCafetiere.quietOff()
		cafetiere.quietOff().silent()
	end
   end
}

