/decl/flooring/ringdown
	abstract_type      = /decl/flooring/ringdown
	force_material     = /decl/material/solid/stone/dustcrete
//	color              = /decl/material/solid/stone/dustcrete::color
	color              = "#374042"

/decl/flooring/ringdown/growth
	name               = "metallic fronds"
	desc               = "A patch of thick, dense, metallic growth that seems rooted in the plate itself."
	icon               = 'mods/ringdown/icons/turfs/growth.dmi'
	icon_base          = "growth"
	footstep_type      = /decl/footsteps/grass
	icon_edge_layer    = FLOOR_EDGE_GRASS_WILD
	color              = "#b5e0d8"
	turf_flags         = TURF_FLAG_BACKGROUND | TURF_IS_HOLOMAP_PATH | TURF_FLAG_ABSORB_LIQUID
	can_engrave        = FALSE
	damage_temperature = T0C+80
	flooring_flags     = TURF_REMOVE_SHOVEL
	growth_value       = 1.2

/decl/flooring/ringdown/growth/get_movable_alpha_mask_state(atom/movable/mover)
	. = ..() || "mask_grass"

/decl/flooring/ringdown/gravel
	name               = "ground"
	icon               = 'mods/ringdown/icons/turfs/barren.dmi'
	desc               = "A thick layer of ringfall, compressed and hardened by time and gravity into something with the consistency of gravel."
	icon_base          = "barren"
	footstep_type      = /decl/footsteps/asteroid
	turf_flags         = TURF_FLAG_BACKGROUND | TURF_IS_HOLOMAP_PATH
	icon_edge_layer    = FLOOR_EDGE_BARREN
	growth_value       = 0.1

/decl/flooring/ringdown/dustcrete
	name               = "dustcrete"
	desc               = "Fused and time-worn ringfall forming a hard stonelike layer underfoot."
	icon               = 'mods/ringdown/icons/turfs/dustcrete.dmi'
	icon_base          = "dustcrete"
	icon_edge_layer    = FLOOR_EDGE_SEAFLOOR
	turf_flags         = TURF_FLAG_BACKGROUND | TURF_IS_HOLOMAP_PATH | TURF_FLAG_ABSORB_LIQUID

/decl/flooring/ringdown/sand
	name               = "ringfall"
	desc               = "A drift of coarse, metallic dust fallen from orbit."
	footstep_type      = /decl/footsteps/sand
	icon               = 'mods/ringdown/icons/turfs/ringfall.dmi'
	icon_base          = "ringfall"
	icon_edge_layer    = FLOOR_EDGE_SAND
	turf_flags         = TURF_FLAG_BACKGROUND | TURF_IS_HOLOMAP_PATH | TURF_FLAG_ABSORB_LIQUID
	color              = /decl/material/solid/stone/dustcrete::color
	growth_value       = 1.2

/decl/flooring/ringdown/structure
	name               = "substructure"
	desc               = "The bones of the Plate, exposed to the air."
	icon               = 'mods/ringdown/icons/turfs/jaggy.dmi'
	color              = "#302b2f"
	force_material     = /decl/material/solid/metal/platemetal
	constructed        = TRUE

/decl/flooring/ringdown/structure/super
	name               = "fundament"
	desc               = "The bared skin of the Plate."
	icon_base          = "structure"
	icon               = 'mods/ringdown/icons/turfs/superstructure.dmi'
	color              = COLOR_GUNMETAL
