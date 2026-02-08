/datum/map/karzerfeste/New()
	LAZYSET(apc_test_exempt_areas, /area/karzerfeste, NO_SCRUBBER|NO_VENT|NO_APC)
	LAZYDISTINCTADD(area_coherency_test_exempted_root_areas, /area/karzerfeste/caves/poi)
	..()
