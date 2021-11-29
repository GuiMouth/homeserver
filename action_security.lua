return {
   active = true,
   on = {
	variables = {
		17,
	},
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Action Security"
   },

   execute = function(domoticz, device)

        local alarm = domoticz.devices('dz_sec_panel')
        local myAlexa = {
                salon = "Alcatraz salon",
                chambre = "Alcatraz Astrid",
                candice = "Candice"
	}
	local alexaSecurity = myAlexa.salon
	local conchitoStatus = domoticz.devices(14)
	if(conchitoStatus.rawData[1] == 'Cleaning' or conchitoStatus.rawData[1] == 'Back to Home' and device.id == 82) then
		alexaSecurity = myAlexa.chambre
        elseif (device.isVariable and alarm.state == domoticz.SECURITY_ARMEDAWAY) then
                if (device.id == 82) then
			alexaSecurity = myAlexa.chambre
                elseif (device.id == 38) then
			alexaSecurity = myAlexa.candice
		end
		
		domoticz.notify("Alarme déclenchée", "Mouvement détecté", domoticz.PRIORITY_HIGH, NSS_PUSHBULLET)
	        domoticz.utils.osExecute('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "' .. alexaSecurity  .. '" -e automation:"testAppel"')

	end
   end
}

