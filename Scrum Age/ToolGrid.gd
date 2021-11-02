extends GridContainer

#Variable to check WHO is in what slot on the map. 0-5, (0 EMPTY, 1 = P1, 2 = P2, etc)
var booleanSlotArray = [0, 0]

func _on_Slot_pressed(slot):
	
	get_parent().touch_slot(get_name(), slot)

##Get colored textures associated with each player, based on player value calling method (NEEDS TO BE UPDATED)
#func _get_Fill_Color(player):
#	match player:
#		1: playerFillColor = blueTexture;		
#	return playerFillColor;
#
#func _on_ToolsButton_pressed():
#	if booleanSlotArray[0] == 0:	
#				$ToolsButton1.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
#				booleanSlotArray[0] = 1;
#				print("TOOL: ");
#				print(booleanSlotArray);												
#	else:	
#		if booleanSlotArray[0] != 0:
#			$ToolsButton1.texture_normal = emptySpace;
#			booleanSlotArray[0] = 0;
#			print("TOOL: ");
#			print(booleanSlotArray);					
#
