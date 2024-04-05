//* Bluespace Radio *//
/obj/item/device/bluespaceradio/relicbase_prelinked
	name = "bluespace radio (forbearance)"
	handset = /obj/item/device/radio/bluespacehandset/linked/relicbase_prelinked

/obj/item/device/radio/bluespacehandset/linked/relicbase_prelinked // Same as Southern Cross. We use their tcomms setup after all
	bs_tx_preload_id = "Receiver A" //Transmit to a receiver
	bs_rx_preload_id = "Broadcaster A" //Recveive from a transmitter
