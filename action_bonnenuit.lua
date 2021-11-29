return {
	active = true,
	on = {
		scenes = {
			3
		},
--		devices = {
--               28,
--	        },
	},
	logging = {
		level = domoticz.LOG_INFO,
		marker = 'Bonne Nuit',
	},
	execute = function(domoticz, scene)
	        local filter = { 'Guirlande' , 'Guirlande_ext01' }
                local guirlandes = domoticz.devices().filter(filter)
		local escalier_rdc2 = domoticz.devices(84)
		local salon = domoticz.groups(4)
		local numerobis = domoticz.devices(60)
                local mamie = domoticz.devices(31)
		local guirlande = domoticz.devices(51)
		local isNoel = domoticz.devices(95)


		
--		escalier_rdc2.cancelQueuedCommands()
--	        escalier_rdc2.setLevel(10)
--	        escalier_rdc2.switchOn().forSec(60)
		salon.switchOff()
		if isNoel.active then
                        guirlandes.forEach(function(device)
				device.switchOff()
			end)
--			guirlande.switchOff()
		end
		if(mamie.active == false) then
			numerobis.setLevel(50)
		end
	end
}
