extends GridContainer

#Variable to check WHO is in what slot on the map. 0-5, (0 EMPTY, 1 = P1, 2 = P2, etc)
var booleanSlotArray = [-1, -1]

func _on_Slot_pressed(slot):
	if Global.meeple_counts[Global.current_player-1] >= 2:
		get_parent().touchHR_slot(get_name(), slot)
	#elif booleanSlotArray[1] != -1:
	#	get_parent().get_node("InfoPanel/Info").text = "There are already meeples here "
	#	get_parent().get_node("Timer").start()
	#else:
	#	get_parent().get_node("InfoPanel/Info").text = "You do not have enough meeples "
	#	get_parent().get_node("Timer").start()
