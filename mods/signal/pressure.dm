#define FLUID_CRUSH_MIN_THRESHOLD (FLUID_DEEP * 2)
#define FLUID_CRUSH_MAX_THRESHOLD FLUID_MAX_DEPTH

/mob/living/carbon/human/calculate_affecting_pressure(pressure)
	var/turf/our_turf = get_turf(src)
	var/fluid_depth = our_turf?.get_fluid_depth()
	if(fluid_depth >= FLUID_CRUSH_MIN_THRESHOLD)
		pressure = max(pressure, min((fluid_depth - FLUID_CRUSH_MIN_THRESHOLD) * (FLUID_CRUSH_MAX_THRESHOLD - FLUID_CRUSH_MIN_THRESHOLD) / (HAZARD_HIGH_PRESSURE - WARNING_HIGH_PRESSURE) + WARNING_HIGH_PRESSURE, HAZARD_HIGH_PRESSURE))
	return ..(pressure)

#undef FLUID_CRUSH_MIN_THRESHOLD
#undef FLUID_CRUSH_MAX_THRESHOLD