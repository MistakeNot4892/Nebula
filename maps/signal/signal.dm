#if !defined(USING_MAP_DATUM)

	#include "..\..\mods\content\mundane.dm"
	#include "..\..\mods\content\corporate\_corporate.dme"
	#include "..\..\mods\content\government\_government.dme"
	#include "..\..\mods\content\psionics\_psionics.dme"
	#include "..\..\mods\content\modern_earth\_modern_earth.dme"
	#include "..\..\mods\species\neocorvids\_neocorvids.dme"
	#include "..\..\mods\signal\_signal.dme"

	#include "signal_areas.dm"
	#include "signal_shuttles.dm"
	#include "signal_unit_testing.dm"

	#include "signal-1.dmm"
	#include "signal-2.dmm"
	#include "signal-3.dmm"

	#define USING_MAP_DATUM /datum/map/signal

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Signal

#endif
