move_x = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
move_x *= move_speed;

if (move_x != 0) {
  image_speed = 1;
  image_xscale = sign(move_x);
}
else {
  image_speed = 0;
}

if (place_meeting(x, y+2, obj_solid)) {
  move_y = 0;
  if (keyboard_check(vk_up) || keyboard_check(ord("W"))) move_y = -jump_speed;
}
else if (move_y < 10) {
  move_y += 1;
}

move_and_collide(move_x, move_y, obj_solid);

if (!place_meeting(x+move_x, y+2, obj_solid) && place_meeting(x+move_x, y+10, obj_solid)) {
    move_y = abs(move_x);
    move_x = 0;
}

var isTouchingWall = (place_meeting(x + 2, y, obj_solid) || place_meeting(x - 2, y, obj_solid));
var isOnGround = place_meeting(x, y + 2, obj_solid);

if (isTouchingWall && !isOnGround) {
    move_y = gravity / 4;
    move_x *= 0.2;
	
    if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
        move_y = -jump_speed;
        if (place_meeting(x + 2, y, obj_solid)) {
            move_x = -4;
        } else {
            move_x = 4;
        }
    }
} else {
    if (isOnGround) {
        move_y = 0;
        if (keyboard_check(vk_up) || keyboard_check(ord("W"))) move_y = -jump_speed;
    } else {
        move_y += gravity;
    }
}
if ( global.lives <= 0) {
    room_goto(r_gameover);
}
if (y > room_height + 50) { 
    global.lives -= 1;
    
    if (global.lives > 0) {
room_restart()
    } else {
        room_goto(rm_gameover);
    }
}