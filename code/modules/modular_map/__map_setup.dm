#define MOD_MAP_CONN_TYPE_HALL "hall"
#define MOD_MAP_CONN_TYPE_ROOM "room"
#define MOD_MAP_CONN_TYPE_TERM "terminator"
#define MOD_MAP_CONN_TYPE_NONE "non-connecting"

/client/verb/test_modular_map_gen()
	set name = "Test Modular Map Gen"
	set category = "Debug"
	set src = usr
	var/decl/modular_map_generator/mapgen = GET_DECL(/decl/modular_map_generator/debug)
	mapgen.generate()
