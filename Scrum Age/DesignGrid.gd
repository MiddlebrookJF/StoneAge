extends GridContainer

#Variable to check WHO is in what slot on the map. 0-4, (-1 EMPTY, 1 = P1, 2 = P2, etc)
var booleanSlotArray = [-1, -1, -1, -1, -1, -1, -1, -1, -1] 

func _on_Slot_pressed(slot):
	if Global.train_scores[Global.current_player-1] >= 15 && Global.req_scores[Global.current_player-1] >= 10:
		get_parent().touch_slot(get_name(), slot)
	else:
		get_parent().get_node("InfoPanel/Info").text = "You do not have enough points "
		get_parent().get_node("Timer").start();
