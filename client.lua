local isAntiLagEnabled = true

local reverse = 0

function ApplyAntiLagEffects(veh)
    local player = PlayerPedId()
    local RPM = GetVehicleCurrentRpm(veh, player)
    local gear = GetVehicleCurrentGear(veh)

    if gear ~= reverse then
        if not IsEntityInAir(veh) then
            if not IsControlPressed(1, 71) and not IsControlPressed(1, 72) then
                if RPM > Config.RPM then
                    TriggerServerEvent("flames", VehToNet(veh))
                    TriggerServerEvent("sound_server:PlayWithinDistance", 25.0,
                        tostring(math.random(1, 6)),
                        0.9)
                    SetVehicleTurboPressure(veh, 25)
                    Wait(math.random(25, Config.explosionSpeed))
                end
            end
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local sleep = 1000
            local player = PlayerPedId()
            local veh = GetVehiclePedIsIn(player, false)

            local itemExists = exports['qs-inventory']:Search('pop_tune')

            if itemExists > 0 and IsPedInAnyVehicle(player, false) then
                ApplyAntiLagEffects(veh)
            end

            Wait(sleep)
        end
    end)


-- Export the AntiLagThread function
exports('AntiLagThread', AntiLagThread)


local exhausts = { "exhaust", "exhaust_2", "exhaust_3", "exhaust_4" }
local fxName = "veh_backfire"
local fxGroup = "core"

RegisterNetEvent('sound_client:PlayWithinDistance')
AddEventHandler('sound_client:PlayWithinDistance', function(coords, disMax, audoFile, audioVol)
    local entityCoords   = GetEntityCoords(PlayerPedId())
    local distance       = #(entityCoords - coords)
    local distanceRatio  = distance / disMax        -- calculate the distance ratio
    local adjustedVolume = audioVol / distanceRatio -- adjust volume based on distance ratio

    if (distance <= disMax) then
        SendNUIMessage({
            transactionType   = 'playSound',
            transactionFile   = audoFile,
            transactionVolume = adjustedVolume -- use the adjusted volume
        })
    end
end)

RegisterNetEvent("client_flames")
AddEventHandler("client_flames", function(vehicle)
    if NetworkDoesEntityExistWithNetworkId(vehicle) then
        for _, bones in pairs(exhausts) do
            local boneIndex = GetEntityBoneIndexByName(NetToVeh(vehicle), bones)
            if boneIndex ~= -1 then
                UseParticleFxAssetNextCall(fxGroup)
                local startParticle = StartParticleFxLoopedOnEntityBone(fxName, NetToVeh(vehicle), 0.0, 0.0, 0.0, 0.0,
                    0.0,
                    0.0,
                    GetEntityBoneIndexByName(NetToVeh(vehicle), bones), Config.flameSize, 0.0, 0.0, 0.0)
                StopParticleFxLooped(startParticle, true)
            end
        end
    end
end)

function message(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
