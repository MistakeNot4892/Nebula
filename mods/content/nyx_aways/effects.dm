/obj/effect/spawner/bomb_simulator
	var/_high = 0
	var/_med = 0
	var/_low = 0

/obj/effect/spawner/bomb_simulator/Initialize()
	. = ..()
	explosion(loc,_high,_med,_low,adminlog = FALSE)