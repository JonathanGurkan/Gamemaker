draw_self();
if (grappling) {
    draw_set_color(c_white);
    draw_line_width(x, y, grapple_point_x, grapple_point_y, 2);
    draw_set_color(c_white);
}