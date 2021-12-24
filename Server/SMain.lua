Refs = setmetatable({ }, Refs)

Refs.Blips = { }

CreateThread(function()
    if not ESX then return print("[guille_policeblips] ^1[ERROR] The resource cannot start due you do not use ESX legacy or you renamed ESX, rename it to 'es_extended'") end
    while true do 
        Wait(Cfg.RefreshRate)
        TriggerClientEvent("refs:client:receiveData", -1, Refs.Blips)
    end
end)

AddEventHandler("playerDropped", function()
    local src <const> = source
    TriggerClientEvent("refs:client:removeRef", -1, src)
    Refs.Blips[tonumber(src)] = nil
end)

local name = "[^4guille_policeblips^7]"

CreateThread(function()
    function checkVersion(error, latestVersion, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')          

        if tonumber(currentVersion) < tonumber(latestVersion) then
            print(name .. " ^1is outdated.\nCurrent version: ^8" .. currentVersion .. "\nNewest version: ^2" .. latestVersion .. "\n^3Update^7: https://github.com/guillerp8/guille_policeblips")
        elseif tonumber(currentVersion) > tonumber(latestVersion) then
            print(name .. " has skipped the latest version ^2" .. latestVersion .. ". Either Github is offline or the version file has been changed")
        else
            print(name .. " is updated.")
        end
    end
    PerformHttpRequest("https://raw.githubusercontent.com/guillerp8/jobcreatorversion/ma/refs", checkVersion, "GET")
end)