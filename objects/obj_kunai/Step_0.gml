if (!stuck) {
    // Kunai beweegt in de richting waarin hij gegooid is
    x += lengthdir_x(10, direction);
    y += lengthdir_y(10, direction);

    // Controleer of de kunai een obj_solid raakt
    if (place_meeting(x, y, obj_solid)) {
        stuck = true; // Zet de kunai vast
        target_x = x;
        target_y = y;
        speed = 0;
    }
} else {
    // Als de speler de muisknop ingedrukt houdt, trek hem naar de kunai toe
    if (grappling) {
        var dx = target_x - owner.x;
        var dy = target_y - owner.y;
        var distance = point_distance(owner.x, owner.y, target_x, target_y);

        if (distance > 4) { // Stop als de speler dichtbij genoeg is
            var pull_speed = 5; // Hoe snel de speler zich aantrekt
            owner.x += dx / distance * pull_speed;
            owner.y += dy / distance * pull_speed;
        } else {
            grappling = false; // Stop met trekken als de speler er is
        }
    }
}

// Verwijder de kunai als de muisknop wordt losgelaten en hij vastzit
if (stuck && !mouse_check_button(mb_left)) {
    instance_destroy();
}
