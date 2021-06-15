/turf/simulated/wall/false
	can_open = 1

/turf/simulated/wall/r_wall/false
	can_open = 1

/turf/simulated/wall/wood/New(var/newloc)
	..(newloc,"wood")

/turf/simulated/floor/plating/airless
	initial_gas = null

/turf/unsimulated/floor/plating
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "plating"

//General tiles, they need to be separate types to survive shuttle use

//Hallway
/decl/flooring/tiling/new_tile/hallway
	color = "#8b9497"

/turf/simulated/floor/tiled/old_tile/hallway
	color = "#8b9497"
	initial_flooring = /decl/flooring/tiling/new_tile/hallway

/decl/flooring/tiling/new_tile/cargo_one/hallway
	color = "#8b9497"

/turf/simulated/floor/tiled/old_cargo/hallway
	color = "#8b9497"
	initial_flooring = /decl/flooring/tiling/new_tile/cargo_one/hallway


//Dark Blue
/decl/flooring/tiling/new_tile/dblue
	color = "#565D61"

/turf/simulated/floor/tiled/old_tile/dblue
	color = "#565D61"
	initial_flooring = /decl/flooring/tiling/new_tile/dblue

/decl/flooring/tiling/new_tile/cargo_one/dblue
	color = "#565D61"

/turf/simulated/floor/tiled/old_cargo/dblue
	color = "#565D61"
	initial_flooring = /decl/flooring/tiling/new_tile/cargo_one/dblue

/decl/flooring/tiling/new_tile/med
	color = "#CCCCCC"


//Medical/Research
/turf/simulated/floor/tiled/old_tile/med
	color = "#CCCCCC"
	initial_flooring = /decl/flooring/tiling/new_tile/med

/decl/flooring/tiling/new_tile/cargo_one/med
	color = "#CCCCCC"

/turf/simulated/floor/tiled/old_cargo/med
	color = "#CCCCCC"
	initial_flooring = /decl/flooring/tiling/new_tile/cargo_one/med


//Dark Grey
/decl/flooring/tiling/new_tile/dgrey
	color = "#666666"

/turf/simulated/floor/tiled/old_tile/dgrey
	color = "#666666"
	initial_flooring = /decl/flooring/tiling/new_tile/dgrey

/decl/flooring/tiling/new_tile/cargo_one/dgrey
	color = "#666666"

/turf/simulated/floor/tiled/old_cargo/dgrey
	color = "#666666"
	initial_flooring = /decl/flooring/tiling/new_tile/cargo_one/dgrey

//Engineering

/obj/effect/paint/biege
	color = COLOR_BEIGE

/obj/effect/floor_decal/borderfloorbiege
	name = "border floor"
	icon_state = "borderfloor_white"
	color = COLOR_BEIGE

/obj/effect/floor_decal/borderfloorbiege/corner
	icon_state = "borderfloorcorner_white"

/obj/effect/floor_decal/borderfloorbiege/corner2
	icon_state = "borderfloorcorner2_white"

/obj/effect/floor_decal/borderfloorbiege/full
	icon_state = "borderfloorfull_white"

/obj/effect/floor_decal/borderfloorbiege/cee
	icon_state = "borderfloorcee_white"

/obj/structure/window/reinforced/full/antique
	paint_color = "#FFFFFF"

/obj/structure/wall_frame/antique
	paint_color = COLOR_BEIGE

/obj/effect/wallframe_spawn/reinforced/antique
	name = "antique wall frame window spawner"
	win_path = /obj/structure/window/reinforced/full/antique
	frame_path = /obj/structure/wall_frame/antique