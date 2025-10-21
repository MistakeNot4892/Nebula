#define MFC_NONE      0
#define MFC_HALL      BITFLAG(0)
#define MFC_ROOM      BITFLAG(1)
#define MFC_AQUEDUCT  BITFLAG(2)
#define MFC_HALL_BEND BITFLAG(3)
#define MFC_BRIDGE    BITFLAG(4)

var/global/list/_mm_all_connection_flags = list(
	(MFC_HALL),
	(MFC_ROOM),
	(MFC_AQUEDUCT),
	(MFC_HALL_BEND),
	(MFC_BRIDGE)
)

/client/verb/test_modular_map_gen()
	set name = "Test Modular Map Gen"
	set category = "Debug"
	set src = usr
	var/decl/modular_map_generator/mapgen = input("Select a generator.") as null|anything in decls_repository.get_decls_of_subtype_unassociated(/decl/modular_map_generator)
	mapgen?.generate()
