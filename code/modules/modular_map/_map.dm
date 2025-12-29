#define TRANSLATE_MODMAP_COORD(X, Y, WIDTH) (((Y * WIDTH) + (X))+1)
#define INVALID_MODMAP_COORDS(X, Y, MX, MY) (X < 0 || X > MX || Y < 0 || Y > MY)

#define MM_X     1
#define MM_Y     2

#define MC_O_X   1
#define MC_O_Y   2
#define MC_DIR   3
#define MC_ROOMS 4

#define R_HALLWAY
#define R_CHAMBER

var/global/alist/_mm_offsets_by_dir = alist(
	(NORTH) = alist((MM_X) =  0, (MM_Y) =  1),
	(SOUTH) = alist((MM_X) =  0, (MM_Y) = -1),
	(EAST)  = alist((MM_X) =  1, (MM_Y) =  0),
	(WEST)  = alist((MM_X) = -1, (MM_Y) =  0)
)

/proc/_mm_get_reference_room(_room_type)
	. = global._room_reference_cache[_room_type]
	if(!.)
		. = new _room_type // no params, reference type only
		global._room_reference_cache[_room_type] = .

/client/verb/test_mapgen()
	set name = "Test Mapgen"
	set category = "Debug"
	var/static/datum/mm_run/run = new(20, 20)
	run.generate_map()
	run.print_map()
