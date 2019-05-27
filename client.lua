Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(250)

		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			Citizen.Wait(0)

			Timer = true
		else
			Timer = false
		end
	end
end)

Citizen.CreateThread(function()
	SendNUIMessage({action = "DisplayOFF", Skin = 'UI'})
	while true do
		Citizen.Wait(1)
		if Timer then
			DisplayHud()
		end
	end
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function GetSeatPedIsIn(ped)
	local vehicle = GetVehiclePedIsIn(ped, false)

	for i = -2, GetVehicleMaxNumberOfPassengers(vehicle) do
		if GetPedInVehicleSeat(vehicle, i) == ped then
			return i
		end
	end

	return -2
end

function DisplayHud()
	local playerPed = GetPlayerPed(-1)
	
	if IsPedInAnyVehicle(playerPed, false) and GetSeatPedIsIn(playerPed) == -1 then
		local vehicle      = GetPlayersLastVehicle()
		local fuel         = math.ceil(round(GetVehicleFuelLevel(vehicle), 1))
		local speed        = GetEntitySpeed(vehicle)
		local kmh          = round(speed * 3.6, 0)
		local mph          = round(speed * 2.236936, 0)
        local rpm          = GetVehicleCurrentRpm(vehicle)
		local engineHealth = GetVehicleEngineHealth(vehicle)
		local gear         = GetVehicleCurrentGear(vehicle)
		--local turbo        = GetVehicleTurboPressure(vehicle)
		
		if not GetIsVehicleEngineRunning(vehicle) then rpm = 0 end 
		
		if rpm > 0.3 then	
		RPM = rpm * 130
		else
		RPM = rpm * 100
		 end 
				
		if fuel == 0 then
			fuel = "0"
		end
		if kmh == 0 then
			kmh = "0"
		end
		if mph == 0 then
			mph = "0"
		end
		
		if RPM == 0 then SendNUIMessage({action = "DisplayOFF", Skin = 'UI'}) else SendNUIMessage({action = "DisplayON", Skin = 'UI'}) end
		
		local D1kmh = kmh % 10
		local D2kmh = math.floor(kmh / 10) % 10
		local D3kmh = math.floor(kmh / 100) % 10
       
		SendNUIMessage({action = "setValueAS", value = RPM})
		SendNUIMessage({action = "setValueAF", value = fuel})
		SendNUIMessage({action = "setNumD1", value = D1kmh})
		SendNUIMessage({action = "setNumD2", value = D2kmh})
		SendNUIMessage({action = "setNumD3", value = D3kmh})
		SendNUIMessage({action = "setNumG", value = gear})
	else
	SendNUIMessage({action = "DisplayOFF", Skin = 'UI'})
	end
end