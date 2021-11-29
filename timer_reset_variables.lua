return {
   active = true,
   on = {
	timer = {
		'at 04:45',
        }
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Timer reset variables"
   },

   execute = function(domoticz, device)

	local isCoffeeReady = domoticz.variables(15)
	local isNumeroBisDone = domoticz.variables(16)
	local isConchitoDone = domoticz.variables(1)
	local conchitoCare = domoticz.variables(4)

        if (device.isTimer) then
		isCoffeeReady.set("non")
		isNumeroBisDone.set("non")
		isConchitoDone.set("non")
		conchitoCare.set("oui")
	end
   end
}

