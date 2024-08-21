//File has been unticked for combat refactor walkback

	movement_cooldown = 3			// Lower is faster.
	aquatic_movement = 0			// If set, the mob will move through fluids with no hinderance.

	minbodytemp = 0			// Minimum "okay" temperature in kelvin
	maxbodytemp = 10000			// Maximum of above
	heat_damage_per_tick = 3	// Amount of damage applied if animal's body temperature is higher than maxbodytemp
	cold_damage_per_tick = 2	// Same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp

/mob/living/simple_mob/vore/aggressive/rat/event
	maxHealth = 25
	health = 25
