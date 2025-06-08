#if !defined(USING_MAP_DATUM)

	#define OVERMAP_ID_RINGDOWN_PLANET "The Plate"

	#include "../../mods/content/mundane.dm"
	#include "../../mods/content/corporate/_corporate.dme"
	#include "../../mods/content/government/_government.dme"
	#include "../../mods/content/modern_earth/_modern_earth.dme"
	#include "../../mods/content/mouse_highlights/_mouse_highlight.dme"
	#include "../../mods/content/psionics/_psionics.dme"
	#include "../../mods/content/scaling_descriptors.dm"
	#include "../../mods/content/xenobiology/_xenobiology.dme"
	#include "../../mods/species/ascent/_ascent.dme"
	#include "../../mods/species/neoavians/_neoavians.dme"
	#include "../../mods/species/utility_frames/_utility_frames.dme"
	#include "../../mods/species/tajaran/_tajaran.dme"
	#include "../../mods/species/unathi/_unathi.dme"
	#include "../../mods/species/vox/_vox.dme"
	#include "../../mods/mobs/dionaea/_dionaea.dme"
	#include "../../mods/content/matchmaking/_matchmaking.dme"
	#include "../../mods/ringdown/_ringdown.dme"

	#include "submaps/_submaps.dm"

	#include "ringdown_areas.dm"
	#include "ringdown_flora.dm"
	#include "ringdown_flooring.dm"
	#include "ringdown_jobs.dm"
	#include "ringdown_maps.dm"
	#include "ringdown_materials.dm"
	#include "ringdown_overmap.dm"
	#include "ringdown_spawn.dm"
	#include "ringdown_species.dm"
	#include "ringdown_turfs.dm"

	#define USING_MAP_DATUM /datum/map/ringdown

/world
	turf = /turf/floor/ringfall
	area = /area/ringdown/wastes

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Ringdown

#endif

