/datum/proc/handle_post_network_connection()
	return

SUBSYSTEM_DEF(networking)
	name = "Computer Networks"
	priority = SS_PRIORITY_COMPUTER_NETS
	flags = SS_BACKGROUND | SS_NO_INIT
	wait = 2 SECOND
	runlevels = RUNLEVEL_INIT | RUNLEVELS_DEFAULT

	var/list/networks = list()
	var/list/connection_queue = list()
	var/list/tmp_queue = list()

/datum/controller/subsystem/networking/fire(resumed = FALSE)
	if(!resumed)
		tmp_queue = connection_queue.Copy()
		connection_queue = list()
	while(tmp_queue.len)
		try_connect(tmp_queue[tmp_queue.len])
		tmp_queue.len--

/datum/controller/subsystem/networking/proc/try_connect(var/datum/extension/network_device/device)
	if(QDELETED(device))
		return
	var/connected
	if(device.network_id)
		connected = device.connect()
	else
		connected = device.connect_to_any()
	if(!connected)
		connection_queue += device

/datum/controller/subsystem/networking/stat_entry()
	..("[length(networks)] network\s, [length(connection_queue)] connection\s queued")

/datum/controller/subsystem/networking/proc/queue_connection(var/datum/extension/network_device/device)
	connection_queue |= device
