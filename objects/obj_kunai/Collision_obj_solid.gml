if (!attached) {
    attached = true;
    speed = 0;
   
    if (owner != noone) {
        with (owner) {
            grappling = true;
            grapple_point_x = other.x;
            grapple_point_y = other.y;
            swing_radius = point_distance(x, y, other.x, other.y);
            swing_angle = point_direction(other.x, other.y, x, y);
            swing_momentum = 0;
            is_climbing = false;
        }
    }
}