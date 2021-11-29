return {
        active = false,
        on = {
                timer = { 'at 19:55'
                },
        },
 logging = {
  level = domoticz.LOG_DEBUG,
  marker = "20h applause Script"
 },


        execute = function(dz, item)
		local allLightsIdx = {
			7, -- Salon
			8, -- Chambre
			9, -- Chambre Candice
			41
		}
		local allLights = dz.devices().filter(allLightsIdx)
                local confinement = dz.devices(43)
		if(dz.time.matchesRule('at 19:55') and confinement.active) then
			dz.utils.osExecute('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e speak:\'Préparez-vous ! Je vous rappelle que dans 5 minutes il sera temps dapplaudir !\'')
                        allLights.forEach(function(light)
                              if (not light.active) then
                                      local dimLight = light.levelVal
                                      light.setLevel(80).forSec(1).repeatAfterSec(1,2).silent()
                                      light.setLevel(dimLight).afterSec(4).forSec(1).silent()
                              else
                                      light.switchOff().forSec(1).repeatAfterSec(1,3).silent()
                              end
                      end)
		end
	end
}
