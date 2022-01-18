/decl/chemical_reaction/organ_meds
	name = "Peridaxon"
	result = /decl/material/liquid/organ_meds
	required_reagents = list(/decl/material/liquid/brute_meds = 1, /decl/material/liquid/cyro_precursor = 1)
	catalysts = list(/decl/material/gas/hydrogen/tritium = 5) //wake me up when I re-add phoron
	result_amount = 1

/decl/chemical_reaction/oxycodone
	name = "Oxycodone"
	result = /decl/material/liquid/painkillers/oxycodone
	required_reagents = list(/decl/material/liquid/ethanol = 1, /decl/material/liquid/painkillers = 1)
	catalysts = list(/decl/material/gas/hydrogen/tritium = 5)
	result_amount = 1

/decl/chemical_reaction/latrazine
	name = "Latrazine"
	result = /decl/material/liquid/latrazine
	required_reagents = list(/decl/material/liquid/organ_meds = 1, /decl/material/liquid/painkillers/oxycodone = 1, /decl/material/liquid/psychotropics = 1, /decl/material/gas/hydrogen/tritium = 10)
	result_amount = 1

/decl/chemical_reaction/cyro_fluid
	name = "Cryogenic Fluid"
	result = /decl/material/liquid/cyro_fluid
	required_reagents = list(/decl/material/liquid/cyro_precursor = 1, /decl/material/solid/ice = 1)
	inhibitors = list(/decl/material/solid/sodium = 1)
	minimum_temperature = (-20 CELSIUS) - 100
	maximum_temperature = -20 CELSIUS
	result_amount = 1

/decl/chemical_reaction/cyro_precursor
	name = "Cryogenic Precursor"
	result = /decl/material/liquid/cyro_precursor
	required_reagents = list(/decl/material/liquid/acetone = 1, /decl/material/liquid/oxy_meds = 1, /decl/material/solid/exotic_matter = 0.1)
	result_amount = 2

/decl/chemical_reaction/trinitricine
	name = "trinitricine"
	result = /decl/material/liquid/trinitricine
	required_reagents = list(/decl/material/liquid/stabilizer = 1, /decl/material/liquid/fertilizer = 1)
	result_amount = 2

/decl/chemical_reaction/hextrazine
	name = "hextrazine"
	result = /decl/material/liquid/hextrazine
	required_reagents = list(/decl/material/liquid/binitricine = 1)
	inhibitors = list(/decl/material/liquid/trinitricine = 0.1)
	result_amount = 1