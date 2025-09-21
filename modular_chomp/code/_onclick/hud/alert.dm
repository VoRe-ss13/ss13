<<<<<<< HEAD
/obj/screen/alert/open_ticket
=======
/atom/movable/screen/alert/open_ticket
>>>>>>> 65a5e0a614 ([MIRROR] fixes one of my first ever coding sins here (#11720))
	icon = 'modular_chomp/icons/logo.dmi'
	icon_state = "32x32"
<<<<<<< HEAD

/obj/screen/alert/open_ticket/Click()
	if(!usr || !usr.client) return

	// Open a new chat with the user
	var/datum/ticket_chat/TC = new()
	TC.T = usr.client.current_ticket
	TC.tgui_interact(usr.client.mob)
=======
>>>>>>> 65a5e0a614 ([MIRROR] fixes one of my first ever coding sins here (#11720))
