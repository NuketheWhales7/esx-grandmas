---------------------------Grandmas----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------
fx_version 'cerulean'

game 'gta5'

description 'Grandmas House by NukeTheWhales7'

author 'NuketheWhales7#7777'

version '1.0.0'

ui_page 'html/index.html'

server_script {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'config.lua',
    'server/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
    'config.lua',
    'client/*.lua'
} 
