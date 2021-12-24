Refs = setmetatable({ }, Refs)
Refs.__Index = Refs
Refs.PlyJob = "unemployed"
Refs.Blips = { }
Refs.HasReferenceEnabled = false
Refs.EnableFastRefresh = false
Refs.ViewReferences = true

-- Heavy native functions
local GetPlayerServerId, DoesBlipExist, NetworkGetEntityOwner, GetPlayerPed, GetPlayerFromServerId = GetPlayerServerId, DoesBlipExist, NetworkGetEntityOwner, GetPlayerPed, GetPlayerFromServerId

if ESX then
    AddEventHandler("onResourceStart", function(resource)
        if resource == GetCurrentResourceName() then
            Refs.PlyJob = ESX.GetPlayerData().job.name
        end
    end)

    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        Refs.PlyJob = ESX.GetPlayerData().job.name
    end)

    RegisterNetEvent('esx:onPlayerLogout', function()
        Refs.PlyJob = "unemployed"
        for k, v in pairs(Refs.Blips) do
            RemoveBlip(v)
        end
        Refs.Blips = { }
        TriggerServerEvent("refs:server:removeRef")
        Refs.HasReferenceEnabled = false
    end)


    RegisterNetEvent('esx:setJob', function(job)
        Refs.PlyJob = job.name
        for k, v in pairs(Refs.Blips) do
            RemoveBlip(v)
        end
        Refs.Blips = { }
        TriggerServerEvent("refs:server:removeRef")
        Refs.HasReferenceEnabled = false
    end)

    -- Update all the blips and adjust it depending on distance and entity network control
    -- @param Blips info array

    Refs.UpdateRefs = function(Data)
        if not Refs.ViewReferences then return end
        CreateThread(function()
            local PlayerPed <const> = PlayerPedId()
            local PedCoords <const>  = GetEntityCoords(PlayerPed)
            
            Refs.EnableFastRefresh  = false
            for k, v in pairs(Data) do
                if v ~= nil then
                    if v.job == Refs.PlyJob then
                        if Refs.Blips[v.src] then
                            if not DoesBlipExist(Refs.Blips[v.src]) then                                
                                Refs.Blips[v.src] = AddBlipForCoord(v.coords) 
                            end
                            if DoesBlipExist(Refs.Blips[v.src]) then
                                if GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(GetPlayerFromServerId(v.src)))) == tonumber(v.src) then
                                    RemoveBlip(Refs.Blips[v.src])
                                    Refs.Blips[v.src] = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(v.src)))
                                end
                            end
                            SetBlipSprite(Refs.Blips[v.src], Cfg.JobsIcons[v.job] or 1)
                            SetBlipColour(Refs.Blips[v.src], v.color)
                            BeginTextCommandSetBlipName('STRING')
                            AddTextComponentSubstringPlayerName(v.name)
                            EndTextCommandSetBlipName(Refs.Blips[v.src])
                            SetBlipCoords(Refs.Blips[v.src], v.coords)
                        else
                            if GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(GetPlayerFromServerId(v.src)))) == tonumber(v.src) then
                                Refs.Blips[v.src] = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(v.src)))
                            else
                                Refs.Blips[v.src] = AddBlipForCoord(v.coords)
                            end
                            SetBlipColour(Refs.Blips[v.src], v.color)
                            SetBlipSprite(Refs.Blips[v.src], Cfg.JobsIcons[v.job] or 1)
                        end
                        if #(PedCoords - v.coords) < 100 and Refs.HasReferenceEnabled then
                            Refs.EnableFastRefresh = true
                        end
                    else
                        RemoveBlip(Refs.Blips[v.src])
                        Refs.Blips[v.src] = nil
                    end
                end
            end
        end)
    end

    -- Update own reference

    Refs.UpdateReference = function()
        CreateThread(function()
            while Refs.HasReferenceEnabled do
                if Refs.EnableFastRefresh then
                    Wait(1000)
                else 
                    Wait(1400)
                end
                local Ped = PlayerPedId()
                TriggerServerEvent("refs:server:UpdateReference", "coords", GetEntityCoords(Ped))
            end
        end)
    end

    -- Remove a reference
    -- @param player id used as index in the blip array

    Refs.RemoveReference = function(id)
        RemoveBlip(Refs.Blips[tonumber(id)])
        Refs.Blips[tonumber(id)] = nil
    end

    RegisterNetEvent("refs:client:receiveData", Refs.UpdateRefs)
    RegisterNetEvent("refs:client:removeRef", Refs.RemoveReference)
else 
    print("[guille_policeblips] ^1[ERROR] The resource cannot start due you do not use ESX legacy or you renamed ESX, rename it to 'es_extended'")
end