
/datum/global_sunlight_handler
	var/redint = 0
	var/greenint = 0
	var/blueint = 0
	var/red = 0.0
	var/green = 0.0
	var/blue = 0.0
	var/cache_r = 0.0
	var/cache_g = 0.0
	var/cache_b = 0.0
	var/datum/sun_holder/sun

//TODO: add support for more than one planet existing
/datum/global_sunlight_handler/New()
	. = ..()
	var/datum/planet/planet = SSplanets.z_to_planet[1]
	sun = planet.sun_holder

/datum/global_sunlight_handler/proc/update_sun()
	var/brightness = sun.our_brightness * SSlighting.sun_mult
	var/list/color = hex2rgb(sun.our_color)
	red = brightness * (color[1] / 255.0)
	green = brightness * (color[2] / 255.0)
	blue = brightness * (color[3] / 255.0)
	redint = round(red * 255)
	greenint = round(green * 255)
	blueint = round(blue * 255)
	var/largest_color_luminosity = max(red, green, blue) // Scale it so one of them is the strongest lum, if it is above 1.
	. = 1 // factor
	if (largest_color_luminosity > 1)
		. = 1 / largest_color_luminosity

	#if LIGHTING_SOFT_THRESHOLD != 0
	else if (largest_color_luminosity < LIGHTING_SOFT_THRESHOLD)
		. = 0 // 0 means soft lighting.

	cache_r  = round(red * ., LIGHTING_ROUND_VALUE) || LIGHTING_SOFT_THRESHOLD
	cache_g  = round(green * ., LIGHTING_ROUND_VALUE) || LIGHTING_SOFT_THRESHOLD
	cache_b  = round(blue * ., LIGHTING_ROUND_VALUE) || LIGHTING_SOFT_THRESHOLD
	#else
	cache_r  = round(red * ., LIGHTING_ROUND_VALUE)
	cache_g  = round(green * ., LIGHTING_ROUND_VALUE)
	cache_b  = round(blue * ., LIGHTING_ROUND_VALUE)
