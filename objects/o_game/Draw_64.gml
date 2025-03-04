if(instance_exists(obj_player)) {
  draw_sprite(coin_pickup, 0, 10, 10);

  draw_set_font(f_arial_black);
  draw_set_halign(fa_left);
  draw_set_valign(fa_middle);
  draw_text(36, 22, string("SCORE: ") + string(global.points));

  for(i = 0; i < global.lives; i += 1) {
    draw_sprite(heart_pickup, 0, 10 + i * 20, 36);
  }
}