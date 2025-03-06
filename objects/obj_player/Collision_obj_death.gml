	global.lives -= 1
	if (global.lives > 0) {
		room_restart()
	}
	else
	{room_goto(r_gameover);
	}