return {
   active = true,
   on = {
        devices = {
                85,
        },
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "Action Cuisine"
   },

   execute = function(domoticz, device)

        local cuisine = domoticz.devices(88)
        local salon = domoticz.devices(7)
	local salonplafond = domoticz.devices(68)

        if (device.isDevice) then
                if (device.active and (salon.active or salonplafond.active)) then
                        if(domoticz.time.matchesRule('at 10:00-00:00')) then
                                cuisine.cancelQueuedCommands()
                                cuisine.switchOn()
                                cuisine.setLevel(100)
                        elseif(domoticz.time.matchesRule('at 00:00-06:00')) then
                                cuisine.cancelQueuedCommands()
                                cuisine.switchOn()
                                if(salon.active) then
					cuisine.setLevel(salon.levelVal)
				else 
					cuisine.setLevel(1)
				end
                        elseif(domoticz.time.matchesRule('at 06:00-10:00')) then
                                cuisine.cancelQueuedCommands()
                                cuisine.switchOn()
                                cuisine.setLevel(salon.levelVal)
                        end
                elseif (device.active == false and cuisine.active) then
                        if(domoticz.time.matchesRule('at 10:00-00:00')) then
	                        cuisine.switchOff().afterMin(2)
                        elseif(domoticz.time.matchesRule('at 00:00-06:00')) then
                                cuisine.switchOff().afterMin(1)
                        elseif(domoticz.time.matchesRule('at 06:00-10:00')) then
                                cuisine.switchOff().afterMin(1)
			end
                end
        end
   end
}
