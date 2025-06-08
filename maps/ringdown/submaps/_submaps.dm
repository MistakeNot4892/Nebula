#include "breakwater/breakwater.dm"
#include "far_shore/far_shore.dm"
#include "coppercreche/coppercreche.dm"
#include "atonal_waterfall/atonal_waterfall.dm"
#include "khakrikita_kha/khakrikita_kha.dm"

/datum/map_template/ruin/ringdown
	prefix          = "maps/ringdown/submaps/"
	abstract_type   = /datum/map_template/ruin/ringdown
	level_data_type = /datum/level_data/ringdown

/obj/abstract/level_data_spawner/ringdown
	level_data_type = /datum/level_data/ringdown

/obj/effect/overmap/visitable/sector/ringdown
	overmap_id = OVERMAP_ID_RINGDOWN_PLANET
