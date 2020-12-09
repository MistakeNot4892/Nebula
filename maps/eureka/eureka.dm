#if !defined(USING_MAP_DATUM)

	#define COLOR_COLONIST "#57564e"
	#define COLOR_LEGION "#4a7077"
	#define COLOR_LEGION_TRIM "#243847"
	#define COLOR_LEGION_OFFICER "#636363"
	#define COLOR_LEGION_OFFICER_TRIM "#381111"

	#define USING_MAP_DATUM /datum/map/eureka

	#include "../../mods/eureka/_eureka.dme"

	#include "eureka-0.dmm"
	#include "eureka-1.dmm"
	#include "eureka-2.dmm"

	#include "eureka_areas.dm"
	#include "eureka_atmos.dm"
	#include "eureka_map.dm"
	#include "eureka_unit_testing.dm"

	#include "jobs/_departments.dm"
	#include "jobs/_jobs.dm"
	#include "jobs/colonist.dm"
	#include "jobs/convict.dm"
	#include "jobs/crown.dm"

	#include "outfits/_outfits.dm"
	#include "outfits/cloaks.dm"
	#include "outfits/colonist.dm"
	#include "outfits/convict.dm"
	#include "outfits/crown.dm"

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Eureka

#endif