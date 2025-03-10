if (global.paused) exit;
var move_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var move_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var move_up = keyboard_check(ord("W")) || keyboard_check(vk_up);
var move_down = keyboard_check(ord("S")) || keyboard_check(vk_down);
var jump = keyboard_check_pressed(vk_space) || keyboard_check(ord("W")) || keyboard_check(vk_up);
var throw_key = keyboard_check_pressed(ord("E"));

if (mouse_check_button_pressed(mb_left) && !kunai_exists && !grappling) {
    kunai_exists = true;
    var kunai = instance_create_layer(x, y, "Instances", obj_kunai);
    kunai.direction = point_direction(x, y, mouse_x, mouse_y);
    kunai.speed = 15;
    kunai.owner = id;
}
// Sprite veranderen op basis van beweging
if (hsp > 0) {
    sprite_index = spr_player_right;
} else if (hsp < 0) {
    sprite_index = spr_player_left;
}

// Loslaten van de grapple
if (!mouse_check_button(mb_left) && grappling) {
    grappling = false;
    kunai_exists = false;
    is_climbing = false;
    is_hanging = false;
    
    var release_speed = min(abs(swing_momentum) * 6, 12);
    var release_angle = swing_angle - 90 * sign(swing_momentum);
    
    hsp = lengthdir_x(release_speed, release_angle);
    vsp = lengthdir_y(release_speed, release_angle);
    
    with (obj_kunai) {
        if (owner == other.id) {
            instance_destroy();
        }
    }
}

// Beweging zonder grapple
if (!grappling) {
    var on_ground = place_meeting(x, y + 1, obj_solid);

    if (on_ground) {
        var target_speed = (move_right - move_left) * movespeed;
        hsp = lerp(hsp, target_speed, 0.2);
        hsp *= ground_friction;
    } else {
        var air_input = (move_right - move_left) * air_control_speed;
        
        if (abs(hsp) < movespeed || sign(air_input) != sign(hsp)) {
            hsp += air_input;
            hsp = clamp(hsp, -movespeed, movespeed);
        }
        
        hsp *= air_friction;
    }

    vsp += grav;
    
    if (vsp > max_fall_speed) {
        vsp = max_fall_speed;
    }

    if (on_ground && jump) {
        vsp = -jumpspeed;
    }
} else {
    // Grapple physics
    prev_angle = swing_angle;

    if (move_up || move_down) {
        is_climbing = true;
        is_hanging = false;
        swing_momentum *= 0.9;
    } else if (!move_left && !move_right) {
        is_hanging = true;
        swing_momentum *= 0.95;
    } else {
        is_climbing = false;
        is_hanging = false;
    }

    if (is_climbing) {
        var climb_direction = move_down - move_up;
        var new_radius = swing_radius + (climb_direction * climb_speed);
        new_radius = clamp(new_radius, min_rope_length, max_rope_length);
        
        var next_x = grapple_point_x + lengthdir_x(new_radius, swing_angle);
        var next_y = grapple_point_y + lengthdir_y(new_radius, swing_angle);

        if (!place_meeting(next_x, next_y, obj_solid)) {
            swing_radius = new_radius;
            x = next_x;
            y = next_y;
        }
    } else {
        var movement_influence = (move_right - move_left) * 0.3;

        if (!is_hanging) {
            swing_momentum += movement_influence;
            swing_momentum += -sin(degtorad(swing_angle)) * 0.25;
        } else {
            var target_angle = 270;
            var angle_diff = angle_difference(target_angle, swing_angle);
            swing_momentum = angle_diff * 0.02;
        }

        swing_momentum *= 0.995;
        swing_momentum = clamp(swing_momentum, -max_swing_speed, max_swing_speed);

        var new_angle = swing_angle + swing_momentum;
        var next_x = grapple_point_x + lengthdir_x(swing_radius, new_angle);
        var next_y = grapple_point_y + lengthdir_y(swing_radius, new_angle);

        if (!place_meeting(next_x, next_y, obj_solid)) {
            x = next_x;
            y = next_y;
            swing_angle = new_angle;
        } else {
            swing_momentum *= -0.7;
        }
    }

    // Loslaten van de grapple met snelheid
    if (throw_key && !is_hanging && abs(swing_momentum) > 2) {
        grappling = false;
        kunai_exists = false;
        is_climbing = false;
        
        var throw_speed = min(abs(swing_momentum) * 10, 15);
        var throw_angle = swing_angle - 90 * sign(swing_momentum);
        
        hsp = lengthdir_x(throw_speed, throw_angle);
        vsp = lengthdir_y(throw_speed, throw_angle);
        
        with (obj_kunai) {
            if (owner == other.id) {
                instance_destroy();
            }
        }
    }
}

// Botsingen en beweging
if (!grappling) {
    if (place_meeting(x + hsp, y, obj_solid)) {
        while (!place_meeting(x + sign(hsp), y, obj_solid)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    if (place_meeting(x, y + vsp, obj_solid)) {
        while (!place_meeting(x, y + sign(vsp), obj_solid)) {
            y += sign(vsp);
        }
        if (vsp > 0) {
            can_jump = true;
        }
        vsp = 0;
    }
    y += vsp;
}


if ( global.lives <= 0) {
    room_goto(r_gameover);
}
if (y > room_height + 50) { 
    global.lives --;
    
    if (global.lives > 0) {
room_restart()
    } else {
        room_goto(r_gameover);
    }
}
