RegisterCommand("reference", function()
    if not Refs.ViewReferences then ESX.ShowNotification(Cfg.Strings[3]) return end
    if not Refs.HasReferenceEnabled then
        Refs.HasReferenceEnabled = true
        local Ped = PlayerPedId()
        Refs.UpdateReference()
        TriggerServerEvent("refs:server:setUpReference", GetEntityCoords(Ped))
        ESX.ShowNotification(Cfg.Strings[1])
    else
        TriggerServerEvent("refs:server:removeRef")
        Refs.HasReferenceEnabled = false
        ESX.ShowNotification(Cfg.Strings[2])
    end
end)

RegisterCommand("viewreferences", function()
    if not Refs.ViewReferences then
        Refs.ViewReferences = true
        ESX.ShowNotification(Cfg.Strings[4])
    else
        ESX.ShowNotification(Cfg.Strings[5])
        TriggerServerEvent("refs:server:removeRef")
        Refs.ViewReferences = false
        for k, v in pairs(Refs.Blips) do
            RemoveBlip(v)
            Refs.Blips[k] = nil
        end
        Refs.Blips = { }
        Refs.HasReferenceEnabled = false
    end
end)

RegisterCommand("changeblipcolor", function(source, args)
    if not tonumber(args[1]) then return end
    TriggerServerEvent("refs:server:UpdateReference", "color", tonumber(args[1]))
end)

RegisterCommand(Cfg.OpenCommand, function()
    for k, v in pairs(Cfg.AllowedJobs) do
        if v == Refs.PlyJob then
            return Refs.OpenReferenceMenu()
        end
    end
    return ESX.ShowNotification(Cfg.Strings[6])
end)

TriggerEvent("chat:addSuggestion", Cfg.OpenCommand, Cfg.Strings[7])