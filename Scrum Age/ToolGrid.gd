extends GridContainer

#Variable to check WHO is in what slot on the map. 0-5, (0 EMPTY, 1 = P1, 2 = P2, etc)
var booleanSlotArray = [-1]
var REQ = [0,0,0,0]
func _on_Slot_pressed(slot):
	
	get_parent().touch_slot(get_name(), slot)
