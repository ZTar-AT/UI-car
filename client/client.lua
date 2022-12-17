ESX = nil
local speedBuffer  =  {}
local velBuffer    =  {}
local beltOn       =  false
local wasInCar     =  false
local SpeedLimit   =  false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

AddEventHandler('seatbelt:sounds', function(soundFile, soundVolume)
	SendNUIMessage({
	  transactionType     = 'playSound',
	  transactionFile     = soundFile,
	  transactionVolume   = soundVolume
	})
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(50)
        local player = PlayerPedId()
        local vehicle
        local speed
        if IsPedSittingInAnyVehicle(player) and not IsPlayerDead(player) then
            DisplayRadar(true)
            vehicle = GetVehiclePedIsIn(player)
            speed = GetEntitySpeed(vehicle)
        elseif not IsPedSittingInAnyVehicle(player) then
            DisplayRadar(false)
        end

        local vhealth = GetVehicleEngineHealth(vehicle)
        local wheel1 = IsVehicleTyreBurst(vehicle,0)
        local wheel11 = GetTyreHealth(vehicle,0)
        local wheel2 = IsVehicleTyreBurst(vehicle,1)
        local wheel12 = GetTyreHealth(vehicle,1)
        local wheel3 = IsVehicleTyreBurst(vehicle,4)
        local wheel13 = GetTyreHealth(vehicle,4)
        local wheel4 = IsVehicleTyreBurst(vehicle,5)
        local wheel14 = GetTyreHealth(vehicle,5)
                
        if (wheel1 == 1 and wheel11 < 1) then
            wheel1status = 'die'
        elseif(wheel1 == 1 and wheel11 < 351) then
            wheel1status = 'acc'
        elseif(wheel1 ~= 1) then
            wheel1status = 'som'
        end

        if (wheel2 == 1 and wheel12 < 1) then
            wheel2status = 'die'
        elseif(wheel2 == 1 and wheel12 < 351) then
            wheel2status = 'acc'
        elseif(wheel2 ~= 1) then
            wheel2status = 'som'
        end

        if (wheel3 == 1 and wheel13 < 1) then
            wheel3status = 'die'
        elseif(wheel3 == 1 and wheel13 < 351) then
            wheel3status = 'acc'
        elseif(wheel3 ~= 1 ) then
            wheel3status = 'som'
        end

        if (wheel4 == 1 and wheel14 < 1) then
            wheel4status = 'die'
        elseif(wheel4 == 1 and wheel14 < 351) then
            wheel4status = 'acc'
        elseif(wheel4 ~= 1) then
            wheel4status = 'som'
        end
		
        local vclass = GetVehicleClass(vehicle)
        local mm = nil
        if (vclass == 8 or vclass == 13) then
            mm = "motor"
        else
            mm = "car"
        end

        if vehicle then  
            SendNUIMessage({
                pauseMenu   = IsPauseMenuActive(),
                inVehicle   = IsPedSittingInAnyVehicle(player),
                kmh         = tostring(math.ceil(speed * 3.6)),
                fuel        = tostring(math.ceil(GetVehicleFuelLevel(vehicle))),
                engine      = tostring(math.ceil(GetVehicleEngineHealth(vehicle))),
                gear        = GetVehicleCurrentGear(vehicle),
                plate       = GetVehicleNumberPlateText(vehicle),
                modelName   = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
                belt        = beltOn,
                enginerunning = GetIsVehicleEngineRunning(vehicle),
                isCar       = IsThisModelACar(GetEntityModel(vehicle)),
				isBike      = IsThisModelABicycle(GetEntityModel(vehicle)),
				zone = GetZoneName(GetEntityCoords(player)),
                type = 'vehicle', 
				health = vhealth,
                w1 = wheel1status,
                w2 = wheel2status,
                w3 = wheel3status,
                w4 = wheel4status,
                motor = mm,
				speedlimit = SpeedLimit
			})
		else
			SendNUIMessage({
                pauseMenu   = IsPauseMenuActive(),
                inVehicle   = IsPedSittingInAnyVehicle(player),
			})
            Citizen.Wait(500)
        end
    end
end)

ZoneNameFull =	{
	['AIRP'] = "Los Santos International Airport", 
    ['ALAMO'] = "Alamo Sea", 
    ['ALTA'] = "Alta", 
    ['ARMYB'] = "Fort Zancudo", 
    ['BANHAMC'] = "Banham Canyon Dr", 
    ['BANNING'] = "Banning", 
    ['BEACH'] = "Vespucci Beach", 
    ['BHAMCA'] = "Banham Canyon", 
    ['BRADP'] = "Braddock Pass", 
    ['BRADT'] = "Braddock Tunnel", 
    ['BURTON'] = "Burton", 
    ['CALAFB'] = "Calafia Bridge", 
    ['CANNY'] = "Raton Canyon", 
    ['CCREAK'] = "Cassidy Creek", 
    ['CHAMH'] = "Chamberlain Hills", 
    ['CHIL'] = "Vinewood Hills", 
    ['CHU'] = "Chumash", 
    ['CMSW'] = "Chiliad Mountain State Wilderness", 
    ['CYPRE'] = "Cypress Flats", 
    ['DAVIS'] = "Davis", 
    ['DELBE'] = "Del Perro Beach", 
    ['DELPE'] = "Del Perro", 
    ['DELSOL'] = "La Puerta", 
    ['DESRT'] = "Grand Senora Desert", 
    ['DOWNT'] = "Downtown", 
    ['DTVINE'] = "Downtown Vinewood", 
    ['EAST_V'] = "East Vinewood", 
    ['EBURO'] = "El Burro Heights", 
    ['ELGORL'] = "El Gordo Lighthouse", 
    ['ELYSIAN'] = "Elysian Island", 
    ['GALFISH'] = "Galilee", 
    ['GOLF'] = "GWC and Golfing Society", 
    ['GRAPES'] = "Grapeseed", 
    ['GREATC'] = "Great Chaparral", 
    ['HARMO'] = "Harmony", 
    ['HAWICK'] = "Hawick", 
    ['HORS'] = "Vinewood Racetrack", 
    ['HUMLAB'] = "Humane Labs and Research", 
    ['JAIL'] = "Bolingbroke Penitentiary", 
    ['KOREAT'] = "Little Seoul", 
    ['LACT'] = "Land Act Reservoir", 
    ['LAGO'] = "Lago Zancudo", 
    ['LDAM'] = "Land Act Dam", 
    ['LEGSQU'] = "Legion Square", 
    ['LMESA'] = "La Mesa", 
    ['LOSPUER'] = "La Puerta", 
    ['MIRR'] = "Mirror Park", 
    ['MORN'] = "Morningwood", 
    ['MOVIE'] = "Richards Majestic", 
    ['MTCHIL'] = "Mount Chiliad", 
    ['MTGORDO'] = "Mount Gordo", 
    ['MTJOSE'] = "Mount Josiah", 
    ['MURRI'] = "Murrieta Heights", 
    ['NCHU'] = "North Chumash", 
    ['NOOSE'] = "N.O.O.S.E", 
    ['OCEANA'] = "Pacific Ocean", 
    ['PALCOV'] = "Paleto Cove", 
    ['PALETO'] = "Paleto Bay", 
    ['PALFOR'] = "Paleto Forest", 
    ['PALHIGH'] = "Palomino Highlands", 
    ['PALMPOW'] = "Palmer-Taylor Power Station", 
    ['PBLUFF'] = "Pacific Bluffs", 
    ['PBOX'] = "Pillbox Hill", 
    ['PROCOB'] = "Procopio Beach", 
    ['RANCHO'] = "Rancho", 
    ['RGLEN'] = "Richman Glen", 
    ['RICHM'] = "Richman", 
    ['ROCKF'] = "Rockford Hills", 
    ['RTRAK'] = "Redwood Lights Track", 
    ['SANAND'] = "San Andreas", 
    ['SANCHIA'] = "San Chianski Mountain Range", 
    ['SANDY'] = "Sandy Shores", 
    ['SKID'] = "Mission Row", 
    ['SLAB'] = "Stab City", 
    ['STAD'] = "Maze Bank Arena", 
    ['STRAW'] = "Strawberry", 
    ['TATAMO'] = "Tataviam Mountains", 
    ['TERMINA'] = "Terminal", 
    ['TEXTI'] = "Textile City", 
    ['TONGVAH'] = "Tongva Hills", 
    ['TONGVAV'] = "Tongva Valley", 
    ['VCANA'] = "Vespucci Canals", 
    ['VESP'] = "Vespucci", 
    ['VINE'] = "Vinewood", 
    ['WINDF'] = "Ron Alternates Wind Farm", 
    ['WVINE'] = "West Vinewood", 
    ['ZANCUDO'] = "Zancudo River", 
    ['ZP_ORT'] = "Port of South Los Santos", 
    ['ZQ_UAR'] = "Davis Quartz" 
}

function isVehicleClassHasBelt(class)
    if (not class) then return false end

    local hasBelt = Config.BeltClass[class];
    if (not hasBelt or hasBelt == nil) then return false end

    return hasBelt;
end 



function GetZoneName(coord)
	local str = GetNameOfZone(coord)
	for k,v in pairs(ZoneNameFull) do 
		if str == k then 
			return v
		end
	end
end 

----------------------------------
--          BELT SYSTEM         --
----------------------------------
IsCar = function(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

Fwv = function (entity)
    local hr = GetEntityHeading(entity) + 90.0
    if hr < 0.0 then hr = 360.0 + hr end
    hr = hr * 0.0174533
    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
		local ped = GetPlayerPed(-1)
		local car = GetVehiclePedIsIn(ped)
		
		if car ~= 0 and (wasInCar or IsCar(car)) then
			wasInCar = true
			--if beltOn then DisableControlAction(0, 75) end
                speedBuffer[2] = speedBuffer[1]
                speedBuffer[1] = GetEntitySpeed(car)
 			if speedBuffer[2] ~= nil 
			   and not beltOn
			   and GetEntitySpeedVector(car, true).y > 1.0  
			   and speedBuffer[1] > Cfg.MinSpeed 
			   and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * Cfg.DiffTrigger) then
			   
				local co = GetEntityCoords(ped)
				local fw = Fwv(ped)
				SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
				Citizen.Wait(1)
				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
			end 
			velBuffer[2] = velBuffer[1]
			velBuffer[1] = GetEntityVelocity(car)
				
			if IsControlJustReleased(0, Cfg.BeltKey) then
				beltOn = not beltOn				  
				if beltOn then 
					TriggerEvent("seatbelt:sounds", "buckle", Cfg.Volume )
					TriggerEvent("okokNotify:SendNotification", {
                        text = "คาดเข็มขัดแล้ว !!!",
                        type = "success",
                        timeout = 5000,
                        layout = "centerRight"
                    })
				else 
					TriggerEvent("seatbelt:sounds", "unbuckle", Cfg.Volume )
					TriggerEvent("okokNotify:SendNotification", {
                        text = "ถอดเข็มขัดแล้ว !!!",
                        type = "error",
                        timeout = 5000,
                        layout = "centerRight"
                    })
				end 
			end
			
		elseif wasInCar then
			wasInCar = false
			beltOn = false
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
		end
		Citizen.Wait(300)
	end
end)

RegisterKeyMapping('carhud', 'car', 'Keyboard', 'B')
RegisterCommand('carhud',function()
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    if car ~= 0 and (wasInCar or IsCar(car)) then
        beltOn = not beltOn				  
        if beltOn then 
            TriggerEvent("seatbelt:sounds", "buckle", Cfg.Volume )
            TriggerEvent("okokNotify:SendNotification", {
                text = "คาดเข็มขัดแล้ว !!!",
                type = "success",
                timeout = 5000,
                layout = "centerRight"
            })
        else 
            TriggerEvent("seatbelt:sounds", "unbuckle", Cfg.Volume )
            TriggerEvent("okokNotify:SendNotification", {
                text = "ถอดเข็มขัดแล้ว !!!",
                type = "error",
                timeout = 5000,
                layout = "centerRight"
            })
        end 
    end
end)

local use = false
Citizen.CreateThread(function()
    local resetSpeedOnEnter = true
    while true do
        Citizen.Wait(100)
        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerPed,false)

        if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then
            if resetSpeedOnEnter then
                maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                SetEntityMaxSpeed(vehicle, maxSpeed)
                resetSpeedOnEnter = false
            end

            if IsControlJustReleased(0,Cfg.CruiseKey) and SpeedLimit then 
                maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                SetEntityMaxSpeed(vehicle, maxSpeed)
                SpeedLimit = false
            elseif IsControlJustReleased(0,Cfg.CruiseKey) and not SpeedLimit then
                cruise = GetEntitySpeed(vehicle)
                SetEntityMaxSpeed(vehicle, cruise)
                SpeedLimit = true
            end
        else
            resetSpeedOnEnter = true
            Citizen.Wait(500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        if beltOn then DisableControlAction(0, 75) end
    end
end)