#define TAG_CULTURE  "culture"
#define TAG_LOCATION "location"
#define TAG_FACTION  "faction"
#define TAG_RELIGION "religion"

// Defined here for consistency, not considered 'cultural' info.
#define TAG_SPECIES  "species"
#define TAG_GENDER   "gender"
#define TAG_AGE      "age"

var/global/list/ALL_CULTURAL_TAGS = list(
	TAG_CULTURE =   "Culture",
	TAG_HOMEWORLD = "Residence",
	TAG_FACTION =   "Faction",
	TAG_RELIGION =  "Beliefs"
)

// Used for populating life event settable field list.
var/global/list/all_settable_character_tags = list(
	TAG_CULTURE =   "Culture",
	TAG_LOCATION =  "Residence",
	TAG_FACTION =   "Faction",
	TAG_RELIGION =  "Beliefs",
	TAG_SPECIES =   "Species",
	TAG_GENDER =    "Gender"
)
