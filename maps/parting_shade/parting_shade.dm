#if !defined(USING_MAP_DATUM)

	#ifdef UNIT_TEST
		#include "../../code/unit_tests/offset_tests.dm"
	#endif

	#include "../../mods/gamemodes/wave_defense/_wave_defense.dme"

	#include "../../mods/content/mundane.dm"
	#include "../../mods/content/corporate/_corporate.dme"
	#include "../../mods/content/government/_government.dme"
	#include "../../mods/content/modern_earth/_modern_earth.dme"
	#include "../../mods/content/mouse_highlights/_mouse_highlight.dme"
	#include "../../mods/content/scaling_descriptors.dm"
	#include "../../mods/content/matchmaking/_matchmaking.dme"
	#include "../../mods/content/pheromones/_pheromones.dme"

	#include "../../mods/species/ascent/_ascent.dme"
	#include "../../mods/species/serpentid/_serpentid.dme"
	#include "../../mods/species/bayliens/_bayliens.dme"
	#include "../../mods/species/vox/_vox.dme"

	#include "areas/_areas.dm"
	#include "jobs/_jobs.dm"
	#include "levels/_level.dm"
	#include "outfits/_outfits.dm"

	#include "parting_shade-0.dmm"

	#define USING_MAP_DATUM /datum/map/parting_shade

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Parting Shade

#endif
