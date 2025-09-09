fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'Original script: MT-Scripts/mt_elevator - Modifications & extensions: By Bigchief'
author 'Martttins'
repository 'https://github.com/MT-Scripts/mt_elevator'
version '2.0.2'

ui_page 'web/build/index.html'

files {
    'config.lua',
    'data/elevator_sounds.dat54.rel',
    'audiodirectory/**/*',
    'web/build/**/*'
}

data_file 'AUDIO_WAVEPACK'  'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'data/elevator_sounds.dat'

shared_script '@ox_lib/init.lua'
shared_script 'config.lua'

client_script 'resource/client.lua'
server_script 'resource/server.lua'

dependencies {
    'ox_target',
    'ox_lib'
}
