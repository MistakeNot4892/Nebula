#if !defined(USING_MAP_DATUM)

	#include "../../mods/content/inertia/_inertia.dme"
	#include "../../mods/content/supermatter/_supermatter.dme"

	#include "antares_areas.dm"
	#include "antares_turbolift.dm"

	#include "antares-1.dmm"
	#include "antares-2.dmm"
	#include "antares-3.dmm"
	#include "antares-4.dmm"

	#define USING_MAP_DATUM /datum/map/antares

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Antares

#endif
