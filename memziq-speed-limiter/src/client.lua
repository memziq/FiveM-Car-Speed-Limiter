local function GetVehicleCategory(vehicle)
    local class = GetVehicleClass(vehicle)
    local categories = {
        [0] = "COMPACT", [1] = "SEDAN", [2] = "SUV", [3] = "COUPE", [4] = "MUSCLE",
        [5] = "SPORTCLASSIC", [6] = "SPORT", [7] = "SUPER", [8] = "MOTORCYCLE", [9] = "OFFROAD",
        [10] = "INDUSTRIAL", [11] = "UTILITY", [12] = "VAN", [13] = "CYCLE", [14] = "BOAT",
        [15] = "HELICOPTER", [16] = "PLANE", [17] = "SERVICE", [18] = "EMERGENCY", [19] = "MILITARY",
        [20] = "COMMERCIAL", [21] = "TRAIN"
    }
    return categories[class] or "UNKNOWN"
end

local function GetSpeedLimit(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
    local category = GetVehicleCategory(vehicle)
    local globalLimit = Config.GlobalSpeedLimit
    if Config.ModelSpeedLimits[model] then
        return math.min(Config.ModelSpeedLimits[model], globalLimit)
    elseif Config.CategorySpeedLimits[category] then
        return math.min(Config.CategorySpeedLimits[category], globalLimit)
    else
        return globalLimit
    end
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local limit = GetSpeedLimit(vehicle)
            SetEntityMaxSpeed(vehicle, limit * 0.27778)
        end
        Citizen.Wait(500)
    end
end)

print("^2Speed limiter started successfully!^0")
print("^2https://linktr.ee/memziq^0")
-- linktr.ee/memziq

