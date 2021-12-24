-- Reference object
-- @param Source id of the player
-- @param Job of the player
-- @param Initial coords of the player
-- @param Name of the player

function Refs.CreateReference(src, job, coords, name)

    local self = {}

    self.src         = src
    self.job         = job
    self.color       = 0
    self.coords      = coords
    self.name        = name

    -- Change the reference color
    -- @param Color id

    self.updateColor = function(color, cb)
        self.color = color
        if cb then
            return cb(true)
        else
            return true
        end
    end

    -- Change the reference coords
    -- @param New coordinates

    self.updateCoords = function(coords, cb)
        self.coords = coords
        if cb then
            return cb(true)
        else
            return true
        end
    end

    return self

end