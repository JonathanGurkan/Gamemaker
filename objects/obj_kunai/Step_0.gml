if (!attached) {
    image_angle = direction;
    if (place_meeting(x, y, obj_solid)) {
        attached = true;
        speed = 0;
        if (owner != noone) {
            with (owner) {
                grappling = true;
                grapple_point_x = other.x;
                grapple_point_y = other.y;
                swing_radius = point_distance(x, y, other.x, other.y);
                swing_angle = point_direction(other.x, other.y, x, y);
            }
        }
    }
    if (x < 0 || x > room_width || y < 0 || y > room_height) {
        with (owner) {
            kunai_exists = false;
        }
        instance_destroy();
    }
}