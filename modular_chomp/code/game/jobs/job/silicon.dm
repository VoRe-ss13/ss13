// /datum/job/ai //TORCHRemoval - We don't need camp protection yet
	// camp_protection = TRUE //TORCHRemoval - We don't need camp protection yet

/datum/job/ai/is_species_banned(species_name, brain_type)
	// Any species can join as AI, including shadekin.
	return FALSE

/datum/job/cyborg/is_species_banned(species_name, brain_type)
	// Any species can join as cyborgs, including shadekin.
	return FALSE
