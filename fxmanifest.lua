fx_version 'cerulean'
game 'gta5'

author 'f4angfantasy & quantummalice'
description 'Elevator that can lock either floors or entire shafts'
version '1.0.0'
 
shared_scripts {
	'@ox_lib/init.lua',
	'@qbx_core/modules/lib.lua',
	'config/config.lua'
}

client_scripts {
	'client/client.lua',
	'@qbx_core/modules/playerdata.lua',
}

lua54 'yes'
