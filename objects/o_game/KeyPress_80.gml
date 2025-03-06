// Wisselt pauze aan/uit
global.paused = !global.paused;

// Toon of verwijder het pauzescherm
if (global.paused) {
    instance_create_layer(0, 0, "Instances", obj_pause);
} else {
    with (obj_pause) instance_destroy();
}
