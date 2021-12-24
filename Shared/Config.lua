Cfg = {} or Cfg

Cfg.Colors = { -- https://docs.fivem.net/docs/game-references/blips/ Bottom of the page
    {label = "Blue", color = 3}
}

Cfg.AllowedJobs = { -- Jobs allowed to use references
    [1] = "police",
}

Cfg.JobsIcons = { -- Icons in the beginning of https://docs.fivem.net/docs/game-references/blips/ (You can leave this white)
    ["police"] = 60
}

Cfg.RefreshRate = 2000 -- Refresh rate from server to client

Cfg.OpenCommand = "ref" -- Command to open the reference menu

Cfg.Strings = {
    [1] = "Own reference has been enabled",
    [2] = "Own reference has been disabled",
    [3] = "Enable all references before",
    [4] = 'References has been enabled',
    [5] = 'References has been disabled',
    [6] = 'Your job does not use references',
    [7] = "Open the reference menu",
    [8] = "Reference menu",
    [9] = "Show/Hide references",
    [10] = "Enable/disable own reference",
    [11] = "Color",
    [12] = "Colors",
}