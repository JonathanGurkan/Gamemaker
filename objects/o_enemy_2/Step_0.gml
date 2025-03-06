sprite_index = spr_enemy_left;
mask_index = spr_enemy_left;

if (health_ <= 0) {
    instance_destroy();
}

if (speed_y < 10) {
    speed_y++;
}

if (invincibility_time > 0) {
    invincibility_time--;
}

if (place_meeting(x + speed_x, y, obj_solid)) {
    while (!place_meeting(x + sign(speed_x), y, obj_solid)) {
        x += sign(speed_x);
    }
    speed_x = 0;
}
x += speed_x;

if (place_meeting(x, y + speed_y, obj_solid)) {
    while (!place_meeting(x, y + sign(speed_y), obj_solid)) {
        y += sign(speed_y);
    }
    speed_y = 0;
}
y += speed_y;

if (instance_exists(obj_player) && global.lives > 0) {
    if (x != obj_player.x) {
        dir = -sign(x - obj_player.x);
    } else {
        dir = choose(-1, 1);
    }
    speed_x = movesp * dir;
}

if (place_meeting(x + speed_x, y, obj_solid)) {
    speed_x = 0;
}

if (speed_x != 0) {
    image_speed = 1;
    image_xscale = -sign(speed_x);
} else {
    image_speed = 0;
}
