#define VV_NUM "Number"
#define VV_TEXT "Text"
#define VV_MESSAGE "Mutiline Text"
#define VV_ICON "Icon"
#define VV_ATOM_REFERENCE "Atom Reference"
#define VV_DATUM_REFERENCE "Datum Reference"
#define VV_MOB_REFERENCE "Mob Reference"
#define VV_CLIENT "Client"
#define VV_ATOM_TYPE "Atom Typepath"
#define VV_DATUM_TYPE "Datum Typepath"
#define VV_TYPE "Custom Typepath"
#define VV_FILE "File"
#define VV_LIST "List"
#define VV_NEW_ATOM "New Atom"
#define VV_NEW_DATUM "New Datum"
#define VV_NEW_TYPE "New Custom Typepath"
#define VV_NEW_LIST "New List"
#define VV_NULL "NULL"
#define VV_RESTORE_DEFAULT "Restore to Default"
#define VV_MARKED_DATUM "Marked Datum"
#define VV_BITFIELD "Bitfield"

#define VV_MSG_MARKED "<br>" + span_small(span_red(span_bold("Marked Object")))
#define VV_MSG_EDITED "<br>" + span_small(span_red(span_bold("Var Edited")))
#define VV_MSG_DELETED "<br>" + span_small(span_red(span_bold("Deleted")))

#define VV_NORMAL_LIST_NO_EXPAND_THRESHOLD 50
#define VV_SPECIAL_LIST_NO_EXPAND_THRESHOLD 150

#define IS_VALID_ASSOC_KEY(V) (!isnum(V))

//Helpers for vv_get_dropdown()
#define VV_DROPDOWN_OPTION(href_key, name) . += "<option value='?_src_=vars;[href_key]=TRUE;target=\ref[src]'>[name]</option>"

//Helpers for vv_do_topic(list/href_list)
#define IF_VV_OPTION(href_key) if(href_list[href_key])

// vv_do_list() keys
#define VV_HK_LIST_ADD "listadd"
#define VV_HK_LIST_EDIT "listedit"
#define VV_HK_LIST_CHANGE "listchange"
#define VV_HK_LIST_REMOVE "listremove"
#define VV_HK_LIST_ERASE_NULLS "listnulls"
#define VV_HK_LIST_ERASE_DUPES "listdupes"
#define VV_HK_LIST_SHUFFLE "listshuffle"
#define VV_HK_LIST_SET_LENGTH "listlen"

// /datum
#define VV_HK_DELETE "delete"
#define VV_HK_EXPOSE "expose"
#define VV_HK_CALLPROC "proc_call"
#define VV_HK_MARK "mark"
#define VV_HK_ADDCOMPONENT "addcomponent"

// /atom
#define VV_HK_ATOM_EXPLODE "turf_explode"
#define VV_HK_ATOM_EMP "turf_emp"

<<<<<<< HEAD
=======
// /atom/movable
#define VV_HK_OBSERVE_FOLLOW "observe_follow"
#define VV_HK_GET_MOVABLE "get_movable"
#define VV_HK_DEADCHAT_PLAYS "deadchat_plays"

// /obj
#define VV_HK_OSAY "osay"
#define VV_HK_FAKE_CONVO "fakepdapropconvo"
#define VV_HK_MASS_DEL_TYPE "mass_delete_type"

// /mob
#define VV_HK_GIB "gib"
#define VV_HK_GIVE_MOB_ACTION "give_mob_action"
#define VV_HK_REMOVE_MOB_ACTION "remove_mob_action"
#define VV_HK_GIVE_SPELL "give_spell"
#define VV_HK_REMOVE_SPELL "remove_spell"
#define VV_HK_GIVE_DISEASE "give_disease"
#define VV_HK_GODMODE "toggle_godmode"
#define VV_HK_DROP_ALL "dropall"
#define VV_HK_REGEN_ICONS "regen_icons"
#define VV_HK_REGEN_ICONS_FULL "regen_icons_full"
#define VV_HK_PLAYER_PANEL "player_panel"
#define VV_HK_BUILDMODE "buildmode"
#define VV_HK_DIRECT_CONTROL "direct_control"
#define VV_HK_GIVE_DIRECT_CONTROL "give_direct_control"
#define VV_HK_OFFER_GHOSTS "offer_ghosts"
#define VV_HK_VIEW_PLANES "view_planes"
#define VV_HK_GIVE_AI "give_ai"
#define VV_HK_GIVE_AI_SPEECH "give_ai_speech"
#define VV_HK_ADDLANGUAGE "addlanguage"
#define VV_HK_REMOVELANGUAGE "remlanguage"
#define VV_HK_ADDVERB "addverb"
#define VV_HK_REMOVEVERB "remverb"
#define VV_HK_ADDORGAN "addorgan"
#define VV_HK_REMOVEORGAN "remorgan"

// /mob/living
#define VV_HK_GIVE_SPEECH_IMPEDIMENT "impede_speech"
#define VV_HK_ADMIN_RENAME "admin_rename"
#define VV_HK_ADD_MOOD "addmood"
#define VV_HK_REMOVE_MOOD "removemood"
#define VV_HK_GIVE_HALLUCINATION "give_hallucination"
#define VV_HK_GIVE_DELUSION_HALLUCINATION "give_hallucination_delusion"
#define VV_HK_GIVE_GUARDIAN_SPIRIT "give_guardian_spirit"

// /mob/living/carbon
#define VV_HK_MODIFY_BODYPART "mod_bodypart"
#define VV_HK_MODIFY_ORGANS "organs_modify"
#define VV_HK_MARTIAL_ART "give_martial_art"
#define VV_HK_GIVE_TRAUMA "give_trauma"
#define VV_HK_CURE_TRAUMA "cure_trauma"

// /mob/living/carbon/human
#define VV_HK_COPY_OUTFIT "copy_outfit"
#define VV_HK_MOD_MUTATIONS "quirkmut"
#define VV_HK_MOD_QUIRKS "quirkmod"
#define VV_HK_SET_SPECIES "setspecies"
#define VV_HK_PURRBATION "purrbation"
#define VV_HK_APPLY_DNA_INFUSION "apply_dna_infusion"
#define VV_HK_TURN_INTO_MMI "turn_into_mmi"
#define VV_HK_TURN_MONKEY "turn_monkey"
#define VV_HK_TURN_ALIEN "turn_alien"
#define VK_HK_TURN_SKELETON "turn_skeleton"
#define VK_HK_TURN_AI "turn_ai"
#define VK_HK_TURN_ROBOT "turn_robot"

>>>>>>> 23a48feba4 ([MIRROR] Signals and God (#11242))
#define VV_HK_WEAKREF_RESOLVE "weakref_resolve"
