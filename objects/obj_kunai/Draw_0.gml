draw_self();
if (attached && owner != noone) {
    draw_set_color(c_white);
    draw_line_width(x, y, owner.x, owner.y, 2);
    draw_set_color(c_white);
}
