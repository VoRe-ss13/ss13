///Protects a datum from being VV'd
#define GENERAL_PROTECT_DATUM(Path)\
##Path/can_vv_get(var_name){\
	return FALSE;\
}\
##Path/vv_edit_var(var_name, var_value){\
	return FALSE;\
}\
##Path/CanProcCall(procname){\
<<<<<<< HEAD
    return FALSE;\
}
=======
	return FALSE;\
}
>>>>>>> 789db280cc ([MIRROR] space cleanup (#10414))
