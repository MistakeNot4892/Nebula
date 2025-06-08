/decl/flooring/grass/sif
	name = "growth"
	desc = "A layer of Sivian moss that has adapted to the sheer cold climate."
	color = "#447171"
	force_material = /decl/material/solid/organic/plantmatter/grass/sif

/decl/flooring/grass/wild/sif
	name = "thick growth"
	desc = "A thick, rough layer of Sivian moss that has adapted to the sheer cold climate."
	color = "#446471"

/decl/flooring/tiling/steel_dirty
	build_type = /obj/item/stack/tile/floor_steel_dirty

/decl/flooring/wood/sif
	color              = /decl/material/solid/organic/wood/sivian::color
	build_type         = /obj/item/stack/tile/wood/sivian
	force_material     = /decl/material/solid/organic/wood/sivian

/decl/flooring/wood/rough/sif
	color              = /decl/material/solid/organic/wood/sivian::color
	build_type         = /obj/item/stack/tile/wood/rough/sivian
	force_material     = /decl/material/solid/organic/wood/sivian

WOOD_TILE_SUBTYPE("sifwood",       sivian,       sivian)
WOOD_TILE_SUBTYPE("rough sifwood", rough/sivian, sivian)
