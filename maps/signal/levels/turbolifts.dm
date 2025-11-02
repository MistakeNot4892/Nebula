/obj/abstract/turbolift_spawner/signal
	icon = 'icons/obj/turbolift_preview_5x5.dmi'
	depth = 2
	lift_size_x = 4
	lift_size_y = 4

/obj/abstract/turbolift_spawner/signal/west
	name = "Signal turbolift map placeholder - West"
	dir = EAST
	areas_to_use = list(
		/area/turbolift/signal/west_deck_one,
		/area/turbolift/signal/west_deck_two
		)

/obj/abstract/turbolift_spawner/signal/east
	name = "Signal turbolift map placeholder - East"
	dir = WEST
	areas_to_use = list(
		/area/turbolift/signal/east_deck_one,
		/area/turbolift/signal/east_deck_two
		)

/obj/abstract/turbolift_spawner/signal/cargo
	name = "Signal turbolift map placeholder - Cargo"
	dir = WEST
	areas_to_use = list(
		/area/turbolift/signal/cargo_deck_one,
		/area/turbolift/signal/cargo_deck_two
		)

/obj/abstract/turbolift_spawner/signal/center
	name = "Signal turbolift map placeholder - Center"
	depth = 3
	areas_to_use = list(
		/area/turbolift/signal/center_deck_one,
		/area/turbolift/signal/center_deck_two,
		/area/turbolift/signal/center_deck_three,
		/area/turbolift/signal/center_deck_four
	)

/area/turbolift/signal/signal

/area/turbolift/signal/west_deck_one

/area/turbolift/signal/west_deck_two

/area/turbolift/signal/east_deck_one

/area/turbolift/signal/east_deck_two

/area/turbolift/signal/cargo_deck_one

/area/turbolift/signal/cargo_deck_two

/area/turbolift/signal/center_deck_one

/area/turbolift/signal/center_deck_two

/area/turbolift/signal/center_deck_three

/area/turbolift/signal/center_deck_four
