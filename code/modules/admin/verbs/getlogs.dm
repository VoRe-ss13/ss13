<<<<<<< HEAD
//This proc allows download of past server logs saved within the data/logs/ folder.
//It works similarly to show-server-log.
/client/proc/getserverlog()
	set name = "Get Server Logs"
	set desc = "Fetch logfiles from data/logs"
	set category = "Admin.Logs"
	browseserverlogs()

=======
ADMIN_VERB(get_server_logs, (R_ADMIN | R_SERVER), "Get Server Logs", "View or retrieve logfiles.", ADMIN_CATEGORY_LOGS)
	user.browseserverlogs()

ADMIN_VERB(get_current_logs, (R_ADMIN | R_SERVER), "Get Current Logs", "View or retrieve logfiles for the current round.", ADMIN_CATEGORY_LOGS)
	user.browseserverlogs(current=TRUE)
>>>>>>> 354766375a ([MIRROR] sort cyborg modules (#11390))

/client/proc/browseserverlogs(current=FALSE, runtimes=FALSE)
	var/log_choice = BROWSE_ROOT_ALL_LOGS
	if(current)
		log_choice = BROWSE_ROOT_CURRENT_LOGS
	else if (runtimes)
		log_choice = BROWSE_ROOT_RUNTIME_LOGS
	var/path = browse_files(log_choice)
	feedback_add_details("admin_verb","VTL") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	if(!path)
		return

	if(file_spam_check())
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")
	switch(tgui_alert(src,"View (in game), Open (in your system's text editor), or Download?", path, list("View", "Open", "Download")))
		if ("View")
			src << browse("<html><pre style='word-wrap: break-word;'>[html_encode(file2text(file(path)))]</pre></html>", list2params(list("window" = "viewfile.[path]")))
		if ("Open")
			src << run(file(path))
		if ("Download")
			src << ftp(file(path))
		else
			return
	to_chat(src, "Attempting to send [path], this may take a fair few minutes if the file is very large.", confidential = TRUE)
