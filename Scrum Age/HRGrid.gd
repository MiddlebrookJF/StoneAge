extends GridContainer

#Variable to check WHO is in what slot on the map. 0-5, (0 EMPTY, 1 = P1, 2 = P2, etc)
var booleanSlotArray = [0, 0]

func _on_Slot_pressed(slot):
	
	get_parent().touchHR_slot(get_name(), slot)

##Get colored textures associated with each player, based on player value calling method (NEEDS TO BE UPDATED)
#func _get_Fill_Color(player):
#	match player:
#		1: playerFillColor = blueTexture;		
#	return playerFillColor;
#
#
#
#func _on_Slot_pressed(slot):
#	match slot:
#		1: 
#			if booleanSlotArray[0] == 0:			
#				$Slot1.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
#				$Slot2.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
#				booleanSlotArray[0] = 1;
#				booleanSlotArray[1] = 1;
#				print(booleanSlotArray);												
#			else:	
#					if booleanSlotArray[0] != 0:
#						$Slot1.texture_normal = emptySpace;	
#						$Slot2.texture_normal = emptySpace;					
#						booleanSlotArray[0] = 0;								
#		2: 
#			if booleanSlotArray[1] == 0:			
#				$Slot1.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
#				$Slot2.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
#				booleanSlotArray[0] = 1;
#				booleanSlotArray[1] = 1;											
#			else:	
#					if booleanSlotArray[1] != 0:
#						$Slot1.texture_normal = emptySpace;	
#						$Slot2.texture_normal = emptySpace;					
#						booleanSlotArray[1] = 0;			
