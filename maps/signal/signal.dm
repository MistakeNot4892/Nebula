#if !defined(USING_MAP_DATUM)

	#include "../../mods/content/mundane.dm"
	#include "../../mods/content/corporate/_corporate.dme"
	#include "../../mods/content/government/_government.dme"
	#include "../../mods/content/psionics/_psionics.dme"
	#include "../../mods/content/modern_earth/_modern_earth.dme"
	#include "../../mods/species/neoavians/_neoavians.dme"
	#include "../../mods/signal/_signal.dme"

	#include "areas/_area.dm"
	#include "areas/heights.dm"
	#include "areas/level_four.dm"
	#include "areas/level_one.dm"
	#include "areas/level_three.dm"
	#include "areas/level_two.dm"
	#include "areas/surface.dm"

	#include "levels/_levels.dm"
	#include "levels/turbolifts.dm"

	#include "shuttles/landmarks.dm"

	#include "jobs/_jobs.dm"
	#include "jobs/_ranks.dm"
	#include "jobs/admin.dm"
	#include "jobs/engineering.dm"
	#include "jobs/medical.dm"
	#include "jobs/police.dm"
	#include "jobs/science.dm"
	#include "jobs/service.dm"

	#include "signal_outfits.dm"
	#include "signal_unit_testing.dm"

	#include "signal-1.dmm"
	#include "signal-2.dmm"
	#include "signal-3.dmm"
	#include "signal-4.dmm"
	#include "signal-5.dmm"
	#include "signal-6.dmm"

	#define USING_MAP_DATUM /datum/map/signal

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Signal

#endif
