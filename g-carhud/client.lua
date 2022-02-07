CarHud = {
    sendNUI = SendNUIMessage,
    thread  = CreateThread,
    sleep   = function(msec)
        return Wait(msec)
    end,
    playerPed = function()
        return PlayerPedId()
    end,
    getVehicle = function()
        return GetVehiclePedIsIn(CarHud.playerPed())
    end,
    getSpeed = function()
        return GetEntitySpeed(CarHud.playerPed());
    end,    
    getVehClass = function()
        return GetVehicleClass(GetVehiclePedIsIn(CarHud.playerPed(), false));
    end,    
    isInVehicle = function()
        return IsPedInAnyVehicle(CarHud.playerPed());
    end,    
    setVehicleSeat = function(seat)
        return GetPedInVehicleSeat(CarHud.getVehicle(), seat);
    end,
    speedoMeter = {
        Init = function()
            while true do 
                local cruiseOn = false
                local inHelicopter = false
                local inAirPlane = false
                local inAnyBoat = false 
                local inBike = false 
                local inAnyCar = false
                local inMotorcycle = false
                local sleep = 1000
                local km = (CarHud.getSpeed()* 3.6)
                local fuelLevel = 0
                if IsPedInAnyVehicle(CarHud.playerPed()) then
                    fuelLevel = GetVehicleFuelLevel(CarHud.getVehicle());
                else
                    fuelLevel = 0
                end
                if CarHud.isInVehicle() then 
                    cinturon = false
                    sleep = 100
                    inHelicopter = false
                    inAirPlane = false
                    inAnyBoat = false 
                    inBike = false 
                    inAnyCar = false
                    inMotorcycle = false
                    local vc = CarHud.getVehClass()
                    if( (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)) then
                        inAnyCar = true
                    elseif(vc == 8) then
                        inMotorcycle = true
                    elseif(vc == 13) then
                        inBike = true
                    elseif(vc == 14) then
                        inAnyBoat = true
                    elseif(vc == 15) then
                        inHelicopter = true
                    elseif(vc == 16) then
                        inAirPlane = true
                    end
                    CarHud.sendNUI({
                        action = "speedometer";
                        fuel   = fuelLevel;
                        damage = GetVehicleEngineHealth(CarHud.getVehicle());
                        engine    = GetVehicleCurrentGear(CarHud.getVehicle());
                        speed  = km;
                    })
                else
                    CarHud.sendNUI({
                        action = 'hideSpeedo';
                    })
                end
                CarHud.sleep(sleep)
            end
        end,
    }
}
CarHud.thread(CarHud.speedoMeter.Init)
