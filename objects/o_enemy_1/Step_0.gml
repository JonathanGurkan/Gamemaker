if (speed_y < 10) {
    speed_y += 0.5;
}

x += speed_x;

if (place_meeting(x + sign(speed_x), y, obj_solid)) {
    while (place_meeting(x, y, obj_solid)) {
        x -= sign(speed_x);
    }

    speed_x = 0;
    alarm[0] = 30;
}

// 🔚 **Randdetectie & omkeren**
if (!place_meeting(x + sign(speed_x) * 5, y + 10, obj_solid)) {
    speed_x = 0;
    alarm[0] = 30;
}

if (place_meeting(x, y + speed_y, obj_solid)) {
    while (!place_meeting(x, y + sign(speed_y), obj_solid)) {
        y += sign(speed_y);
    }
    speed_y = 0;
}
y += speed_y;

if (speed_x != 0) {
    image_xscale = -sign(speed_x);
}
