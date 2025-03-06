invincibility_time--

sprite_index = spr_enemy_left
mask_index = spr_enemy_left
if health_ <= 0 {
  instance_destroy();
}


 if (speed_y < 10) {
  speed_y ++

invincibility_time--;

sprite_index = spr_enemy_left;
mask_index = spr_enemy_left;
if (health_ <= 0) {
    instance_destroy();
}

if (speed_y < 10) {
    speed_y++;
}

if (wait_timer <= 0) {
    speed_x = movesp * hDirection;
    
    if (place_meeting(x + speed_x, y, obj_solid)) {
         while (!place_meeting(x + sign(speed_x), y, obj_solid)) {
            x += sign(speed_x);
        }
        speed_x = 0;
        wait_timer = room_speed; // 1 seconde wachten (als room_speed = 60)
        hDirection = -hDirection; // Draai de richting om
    }
} else {
    wait_timer--;
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

dir = -sign(x-obj_player.x)
if (instance_exists(obj_player) && global.lives >= 0) {
	speed_x = movesp * dir
}


if (speed_x != 0) {
    image_speed = 1;
    image_xscale = -sign(speed_x);
} else {
    image_speed = 0;
}
if (instance_exists(obj_player) && obj_player.y < y) {
    sprite_index = spr_enemy_left;
}
 }