fx_version 'cerulean'
game 'gta5'
lua54 'yes'


shared_scripts {
    '@es_extended/imports.lua',
	'@ox_lib/init.lua',
	-- 'modules/init.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    'config.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/*.lua',
}