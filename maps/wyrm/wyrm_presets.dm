var/const/NETWORK_SUBWYRM		= "Sub Deck"
var/const/NETWORK_PRIMWYRM		= "Primary Deck"
var/const/NETWORK_COMMAND		= "Command"
var/const/NETWORK_HATCHLING		= "Hatchling"

/datum/map/wyrm/get_network_access(var/network)
	switch(network)
		if(NETWORK_COMMAND)
			return access_heads
		if(NETWORK_SUBWYRM)
			return access_engine_equip
		if(NETWORK_PRIMWYRM)
			return access_security
	return ..()

/datum/map/wyrm
	station_networks = list(
		NETWORK_SUBWYRM,
		NETWORK_PRIMWYRM,
		NETWORK_COMMAND,
		NETWORK_ENGINEERING,
		NETWORK_MEDICAL,
		NETWORK_RESEARCH,
		NETWORK_MINE,
		NETWORK_ROBOTS,
		NETWORK_SECURITY,
		NETWORK_ALARM_ATMOS,
		NETWORK_ALARM_CAMERA,
		NETWORK_ALARM_FIRE,
		NETWORK_ALARM_MOTION,
		NETWORK_ALARM_POWER,
		NETWORK_HATCHLING,
		NETWORK_THUNDER
	)

//
// Cameras
//

// Networks

/obj/machinery/camera/network/command
	network = list(NETWORK_COMMAND)

/obj/machinery/camera/network/primdeck
	network = list(NETWORK_PRIMWYRM)

/obj/machinery/camera/network/subdeck
	network = list(NETWORK_SUBWYRM)

/obj/machinery/camera/network/research
	network = list(NETWORK_RESEARCH)

/obj/machinery/camera/network/hatchling
	network = list(NETWORK_HATCHLING)

// Motion
/obj/machinery/camera/motion/command
	network = list(NETWORK_COMMAND)

// X-ray
/obj/machinery/camera/xray/security
	network = list(NETWORK_SECURITY)

//Special explorer camera
/obj/machinery/camera/network/exploration
	network = list(NETWORK_HATCHLING)

/obj/machinery/telecomms/hub/preset/wyrm
	network = "wyrm"
	autolinkers = list("busWyrm", "serverWyrm", "receiverWyrm", "broadcasterWyrm", "prim_relay", "sub_relay")
	light_color = "#4b734b"
	light_power = 0.6
	light_range = 4

/obj/machinery/telecomms/bus/preset_wyrm
	id = "Main Bus"
	network = "wyrm"
	freq_listening = list(AI_FREQ, COMM_FREQ, ENG_FREQ, ENT_FREQ, MED_FREQ, PUB_FREQ, SCI_FREQ, SUP_FREQ)
	autolinkers = list("processorWyrm", "busWyrm")
	light_color = "#4b734b"
	light_power = 0.6
	light_range = 4

/obj/machinery/telecomms/processor/preset_wyrm
	id = "Main Processor"
	network = "wyrm"
	autolinkers = list("processorWyrm")
	light_color = "#4b734b"
	light_power = 0.6
	light_range = 4

/obj/machinery/telecomms/server/presets/wyrm
	id = "Wyrm NAS"
	network = "wyrm"
	freq_listening = list(AI_FREQ, COMM_FREQ, ENG_FREQ, ENT_FREQ, MED_FREQ, PUB_FREQ, SCI_FREQ, SUP_FREQ)
	channel_tags = list(
		list(AI_FREQ, "AI Private", "#ff00ff"),
		list(COMM_FREQ, "Command", "#395a9a"),
		list(ENG_FREQ, "Engineering", "#a66300"),
		list(ENT_FREQ, "Entertainment", "#6eaa2c"),
		list(MED_FREQ, "Medical", "#008160"),
		list(PUB_FREQ, "Common", "#008000"),
		list(SCI_FREQ, "Science", "#993399"),
		list(SUP_FREQ, "Supply", "#7f6539")
	)
	autolinkers = list("serverWyrm", "busWyrm")
	light_color = "#4b734b"
	light_power = 0.6
	light_range = 4

/obj/machinery/telecomms/broadcaster/preset_wyrm
	id = "Wyrm Broadcaster"
	network = "wyrm"
	autolinkers = list("broadcasterWyrm")
	light_color = "#4b734b"
	light_power = 0.6
	light_range = 4

/obj/machinery/telecomms/receiver/preset_wyrm
	id = "Wyrm Receiver"
	network = "wyrm"
	freq_listening = list(AI_FREQ, COMM_FREQ, ENG_FREQ, ENT_FREQ, MED_FREQ, PUB_FREQ, SCI_FREQ, SUP_FREQ)
	autolinkers = list("receiverWyrm")
	light_color = "#4b734b"
	light_power = 0.6
	light_range = 4

/obj/structure/closet/secure_closet/engineering_tools
	name = "high-performance tools locker"
	closet_appearance = /decl/closet_appearance/secure_closet/engineering_tools
	req_access = list(access_engine_equip)

/obj/structure/closet/secure_closet/engineering_tools/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/rcd_ammo = 80, /obj/item/rcd_ammo/large = 20)),
		new/datum/atom_creator/weighted(list(/obj/item/rcd_ammo = 70, /obj/item/rcd_ammo/large = 30)),
		/obj/item/rcd_ammo = 2,
		/obj/item/rcd,
		/obj/item/rpd,
		/obj/item/paint_sprayer
	)

/decl/closet_appearance/secure_closet/engineering_tools
	color = COLOR_OFF_WHITE
	decals = list(
		"lower_half_solid"
	)
	extra_decals = list(
		"tool" = COLOR_GOLD,
		"eng_narrow" = COLOR_GOLD
	)
