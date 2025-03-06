if (!variable_global_exists("music")) {
    global.music = -1; 
}

if (!audio_is_playing(global.music)) {
    global.music = audio_play_sound(sou_game, true, 0);
}
