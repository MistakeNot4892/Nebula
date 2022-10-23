/datum/map/borderworld
	name = "Borderworld"
	full_name = "the Borderworld"
	path = "borderworld"
	exterior_atmos_composition = list(
		/decl/material/gas/oxygen = MOLES_O2STANDARD,
		/decl/material/gas/nitrogen = MOLES_N2STANDARD
	)
	exterior_atmos_temp = T20C + 15

/datum/map/borderworld/get_map_info()
	return "<b>The borderworlds</b> are a collection of haphazardly terraformed dwarf planets scattered between the Sun and the outer reaches of the Solar system, usually mixed in with the Kuiper Belt or hidden in the Oort. In the resource boom following human expansion from Mars, it was relatively easy for a rich, excitable industry mogul to crash a few ice asteroids into a Pluto-sized ball of dirt and call it their home away from home. Due to long-term neglect and abuse, and the often horrible conditions on the borderworlds, almost all of the colonies established there have long since gone dark. Sometimes, though, a ship is unfortunate enough to crash on one of the desolate, abandoned planets, leaving the 'colonists' to eke out whatever existence they can manage."

/datum/map/borderworld/apply_ambient_exterior_light(var/turf/target)
	if(isStationLevel(target.z))
		target.set_ambient_light("#ffffcc", 1)
		return TRUE
	return ..()

/obj/abstract/map_data/borderworld
	name = "borderworld"
	desc = "The planet surface and the mining level."
	height = 2
