-- Open the menu with the reference management options

Refs.OpenReferenceMenu = function()
    ESX.UI.Menu.Open('default',GetCurrentResourceName(),"ref_menu",
    { 
    title = Cfg.Strings[8], 
    align = "bottom-right", 
    elements = {
        { label = Cfg.Strings[9],  value = "togglerefs" },
        { label = Cfg.Strings[10], value = "toggleownref" },
        { label = Cfg.Strings[11], value = "color" },
    }
    }, function(data, menu)
        local v = data.current.value
        if v == "togglerefs" then
            ExecuteCommand("viewreferences")
        elseif v == "toggleownref" then
            ExecuteCommand("reference")
        elseif v == "color" then
            menu.close()
            local colorData = { }
            for k, v in pairs(Cfg.Colors) do
                table.insert(colorData, { label = v.label, value = v.color })
            end
            
            ESX.UI.Menu.Open('default',GetCurrentResourceName(),"color_menu",
            { 
            title = Cfg.Strings[12], 
            align = "bottom-right", 
            elements = colorData, 
            }, function(data2, menu2)
                ExecuteCommand("changeblipcolor " ..data2.current.value)
            end, function(data2, menu2) 
                menu2.close() 
                Refs.OpenReferenceMenu()
            end)
        end
    end, function(data, menu) 
        menu.close() 
    end)
end
