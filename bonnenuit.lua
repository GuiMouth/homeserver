return {
   active = true,
   on = {
        variables = {
                3,
        },
   },
   logging = {
        level = domoticz.LOG_ERROR,
        marker = "bonnenuit.lua"
   },

execute = function(domoticz, item)

	local isCoffeeReady = domoticz.variables(15)
	
	if (isCoffeeReady.value == "non") then
		domoticz.executeShellCommand('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e speak:"Mais avant avez vous préparez le café ?"')
	else
		domoticz.executeShellCommand('/home/guimouth/domoticz/scripts/alexa_remote_control.sh -d "Alcatraz salon" -e speak:" Et votre café sera chaud demain matin !"')
	end
end

}
