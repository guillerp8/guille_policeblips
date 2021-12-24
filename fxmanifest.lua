fx_version 'cerulean'

game 'gta5'

version '1.0'

lua54 'yes'

description 'A reference system that works with all the jobs included in the config file (is named guille_policeblips but works with all the jobs btw)'

author 'guillerp#1928'

collaborator 'Olvidate#8295'

shared_scripts {
    '@es_extended/imports.lua',
    './Shared/Config.lua'
}


client_scripts {
    './Client/CMain.lua',

    './Client/Commands.lua',
    './Client/Menu.lua',
}

server_scripts {
    
    './Server/SMain.lua',

    './Server/Classes/Ref.lua',
    './Server/Functions/Functions.lua',
}