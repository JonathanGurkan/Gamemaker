
move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x *= move_speed;

if (move_x != 0) {
  image_speed = 1;
  image_xscale = sign(move_x);
}
else {
  image_speed = 0;
}
if (place_meeting(x, y+2, obj_solid))
{
  move_y = 0;
  if (keyboard_check(vk_up)) move_y = -jump_speed;
}
else if (move_y < 10) {
  move_y += 1;
}
move_and_collide(move_x, move_y, obj_solid);
if (!place_meeting(x+move_x, y+2, obj_solid) && place_meeting(x+move_x, y+10, obj_solid))
{
    move_y = abs(move_x);
    move_x = 0;
}
(keyboard_check(vk_left) or keyboard_check(ord("A"))