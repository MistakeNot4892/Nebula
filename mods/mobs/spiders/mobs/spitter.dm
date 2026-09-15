//spitters - fast, comparatively weak, very venomous; projectile attacks but will resort to melee once out of ammo
/mob/living/simple_animal/hostile/giant_spider/spitter
	desc = "A monstrously huge iridescent spider with shimmering eyes."
	icon = 'mods/mobs/spiders/icons/spider_purple.dmi'
	max_health = 90
	poison_per_bite = 15
	projectiletype = /obj/item/projectile/venom
	projectilesound = 'sound/effects/hypospray.ogg'
	fire_desc = "spits venom"
	ranged_range = 6
	flash_protection = FLASH_PROTECTION_REDUCED
	natural_weapon = /obj/item/natural_weapon/bite/weak
	max_ranged_charge = 16

/mob/living/simple_animal/hostile/giant_spider/spitter/get_door_pry_time()
	return 7 SECONDS
