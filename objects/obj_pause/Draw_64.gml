var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();


draw_set_alpha(0.8); 
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1); 


draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(gui_w / 2, gui_h / 2, "PAUZE - Druk op P om verder te gaan");
