return {
   active = true,
   on = {
        devices = {
                29,
        },
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "prise1.lua"
   },

execute = function(domoticz, item)

	local cafetiere = domoticz.devices(39)

	if item.active then
		domoticz.triggerIFTTT("CAFETIERE_ON")
	else
		domoticz.triggerIFTTT("CAFETIERE_OFF")
		cafetiere.switchOff()
	end  
end
}
