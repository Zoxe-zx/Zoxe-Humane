fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'Humane Mission'
author '! ^Zoxe$#5386'
version "1.0.0"
repository "https://github.com/anosmus/Zoxe-Humane"
description 'Zoxe-Humane'
discord 'https://discord.gg/avJYpPCfuG'

shared_script "@es_extended/imports.lua"
shared_script '@ox_lib/init.lua'

client_scripts {
    'Client.lua',
    'Function.lua'
} 

shared_script {
    'Config.lua'
} 

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Server.lua'
}

dependencies {
    'ox_target',
    'ox_lib',
    'ox_inventory'
}