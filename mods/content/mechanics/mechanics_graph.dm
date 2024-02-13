/datum/graph/mechanical
	var/list/sources
	var/list/sinks

/datum/graph/mechanical/New()
	. = ..()
	START_PROCESSING(SSmechanics, src)

/datum/graph/mechanical/Destroy()
	STOP_PROCESSING(SSmechanics, src)
	. = ..()

/datum/graph/mechanical/Connect(var/datum/node/node, var/list/neighbours, var/queue = TRUE)
	. = ..()
	RegisterPower(node)

/datum/graph/mechanical/Disconnect(var/datum/node/node, var/list/neighbours, var/queue = TRUE)
	. = ..()
	LAZYREMOVE(sinks,   node)
	LAZYREMOVE(sources, node)

/datum/graph/mechanical/OnMerge(datum/graph/other)
	. = ..()
	if(!istype(other, /datum/graph/mechanical))
		return
	var/datum/graph/mechanical/mech_other = other
	if(mech_other.sources)
		if(sources)
			sources |= mech_other.sources
			LAZYCLEARLIST(mech_other.sources)
		else
			sources = mech_other.sources
			mech_other.sources = null
	if(mech_other.sinks)
		if(sinks)
			sinks |= mech_other.sinks
			LAZYCLEARLIST(mech_other.sinks)
		else
			sinks = mech_other.sinks
			mech_other.sinks = null

/datum/graph/mechanical/OnSplit(list/subgraphs)
	. = ..()
	for(var/datum/graph/mechanical/graph in subgraphs)
		graph.RebuildPower()

/datum/graph/mechanical/proc/RebuildPower()
	LAZYCLEARLIST(sources)
	LAZYCLEARLIST(sinks)
	for(var/datum/node/physical/node in nodes)
		RegisterPower(node)

/datum/graph/mechanical/proc/RegisterPower(datum/node/physical/node)
	if(!istype(node))
		return
	var/obj/structure/mechanical/machine = node.holder
	if(istype(machine))
		if(machine.is_mechanical_sink())
			LAZYDISTINCTADD(sinks, node)
		if(machine.is_mechanical_source())
			LAZYDISTINCTADD(sources, node)
