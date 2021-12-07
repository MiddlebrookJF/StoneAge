extends GridContainer

#Variable to check WHO is in what slot on the map. 0-4, (-1 EMPTY, 0 = P1, 1 = P2, etc)
var booleanSlotArray = [-1, -1, -1, -1, -1, -1, -1, -1, -1] 
var REQ = [0,0,0,0]
func _on_Slot_pressed(slot):
	
	get_parent().touch_slot(get_name(), slot)
