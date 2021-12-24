-- Return an array with all the references
-- @param Callback not needed (optional)
-- @return Array with all the references

Refs.GetAllRefs = function(cb)
    if cb then
        cb(Refs.Blips)
    else
        return Refs.Blips
    end
end

-- Create a new reference object
-- @param Initial coords
-- @param Callback not needed (optional)

Refs.SetUpReference = function(coords, cb)
    local src <const> = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local name = xPlayer.getName() or GetPlayerName(src)
    for i = 1, #Cfg.AllowedJobs do
        if xPlayer.job.name == Cfg.AllowedJobs[i] then
            Refs.Blips[tonumber(src)] = Refs.CreateReference(src, xPlayer.job.name, coords, name) 
        end
    end
end

-- Returns a reference object
-- @param Player id with reference coords
-- @param Callback not needed (optional)
-- @return Reference object

Refs.GetReference = function(id, cb)
    if not Refs.Blips[tonumber(id)] then return end
    if cb then
        return cb(Refs.Blips[tonumber(id)])
    else
        return Refs.Blips[tonumber(id)]
    end
end

-- Specific reference object modifier
-- @param What data must be modified
-- @param The data that will replace the previous one

Refs.UpdateRefs = function(type, data)
    local src <const> = source
    if type == "coords" then
        Refs.GetReference(src, function(refData)
            refData.updateCoords(data)
        end)
    elseif type == "color" then
        Refs.GetReference(src, function(refData)
            refData.updateColor(data)
        end)
    end
end

-- Removes a reference and sync it with all the clients

Refs.RemoveReference = function()
    local src <const> = source
    TriggerClientEvent("refs:client:removeRef", -1, src)
    Refs.Blips[tonumber(src)] = nil
end

RegisterNetEvent("refs:server:setUpReference", Refs.SetUpReference)
RegisterNetEvent("refs:server:UpdateReference", Refs.UpdateRefs)
RegisterNetEvent("refs:server:removeRef", Refs.RemoveReference)