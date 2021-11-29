return {
   active = true,
   on = {
        devices = {
                51,
        },
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "sapin.lua"
   },

execute = function(domoticz, item)

--	local cafetiere = domoticz.devices(39)

	if item.active then
		domoticz.triggerIFTTT("GUIRLANDE_ON")
	elseif not item.active then
		domoticz.triggerIFTTT("GUIRLANDE_OFF")
--		cafetiere.switchOff()
	end  
end
}
