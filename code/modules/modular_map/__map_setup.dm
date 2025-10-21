#define MOD_MAP_CONN_TYPE_HALL "hall"
#define MOD_MAP_CONN_TYPE_ROOM "room"
#define MOD_MAP_CONN_TYPE_NONE "non-connecting"

/client/verb/test_modular_map_gen()
	set name = "Test Modular Map Gen"
	set category = "Debug"
	set src = usr
	var/decl/modular_map_generator/mapgen = input("Select a generator.") as null|anything in decls_repository.get_decls_of_subtype_unassociated(/decl/modular_map_generator)
	mapgen?.generate()
