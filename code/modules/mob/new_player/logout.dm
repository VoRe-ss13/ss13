/mob/new_player/Logout()
	ready = 0

<<<<<<< HEAD
	// see login.dm
	if(my_client)
		my_client.screen -= lobby_image
		my_client = null
=======
	GLOB.new_player_list -= src
	QDEL_NULL(lobby_window)
	disable_lobby_browser()
>>>>>>> 56a4a1a592 ([MIRROR] lobby screen subsystem (#10859))

	..()

	//if(created_for)
		//del_mannequin(created_for) No need to delete this, honestly. It saves up hardly any memory in the long run and fucks the GC in the short run.

	if(!spawning)//Here so that if they are spawning and log out, the other procs can play out and they will have a mob to come back to.
		key = null//We null their key before deleting the mob, so they are properly kicked out.
		qdel(src)
	return
