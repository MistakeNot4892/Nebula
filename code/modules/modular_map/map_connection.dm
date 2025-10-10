// Connection data for use by the modular map generator and templates
/datum/modular_map_connection
	/// Outgoing/facing direction of this connection.
	var/direction_string
	// Incoming/reverse facing direction of this connection.
	var/reverse_direction_string
	/// x-offset within the overall map structure (0 is hard left)
	var/offset_x
	/// y-offset within the overall map structure (0 is hard bottom).
	var/offset_y
	/// x-offset for the cell this connection would connect to.
	var/target_x = 0
	/// y-offset for the cell this connection would connect to.
	var/target_y = 0
	/// A list of valid connection constants for sections joining with this connection.
	var/list/connection_types
	/// Reference to our owning template to simplify connection compatibility checking.
	var/datum/map_template/modular_map/template

/datum/modular_map_connection/proc/can_connect_to(datum/modular_map_connection/other)

	// Connections are not aligned; no dice.
	if(direction_string != other.reverse_direction_string)
		return FALSE

	// Null connections just need to be facing another null connection, they don't care about template compat.
	var/self_dummy = (MOD_MAP_CONN_TYPE_NONE in connection_types)
	var/other_dummy = (MOD_MAP_CONN_TYPE_NONE in other.connection_types)
	if(self_dummy || other_dummy)
		return self_dummy == other_dummy

	// Connection type is not permitted from this template; still no dice.
	if(!(template.connection_type in other.connection_types))
		return FALSE

	// Connection type is not permitted to that template; still no dice.
	if(!(other.template.connection_type in connection_types))
		return FALSE

	return TRUE

/datum/modular_map_connection/New(_dir, _x, _y, _connect)

	offset_x = _x
	offset_y = _y

	direction_string = _dir
	switch(direction_string)
		if("NORTH")
			reverse_direction_string = "SOUTH"
			target_y = 1
		if("SOUTH")
			reverse_direction_string = "NORTH"
			target_y = -1
		if("EAST")
			reverse_direction_string = "WEST"
			target_x = 1
		if("WEST")
			reverse_direction_string = "EAST"
			target_x = -1

	connection_types = _connect
	if(connection_types && !islist(connection_types))
		connection_types = list(connection_types)
