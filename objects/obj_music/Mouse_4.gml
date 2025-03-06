global.sound_on = !global.sound_on;

if (global.sound_on) {
    audio_master_gain(1);
} else {
    audio_master_gain(0); 
}
