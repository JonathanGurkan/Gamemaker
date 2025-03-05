acceleration = .05;
max_speed = 2;
movesp = 2
health_ = 1;
dir = 0;
invincibility_time = 0
speed_x = 1;
speed_y = 0;
if (choose(0, 1) == 0) {
    speed_x *= -1;
}
image_xscale = sign(speed_x);
