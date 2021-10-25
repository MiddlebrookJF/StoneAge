extends GridContainer

#Variable to check WHO is in what slot on the map. 0-5, (0 EMPTY, 1 = P1, 2 = P2, etc)
var booleanSlotArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]



#Get colored textures associated with each player, based on player value calling method (NEEDS TO BE UPDATED)
func _get_Fill_Color(player):
	match player:
		1: playerFillColor = blueTexture;		
	return playerFillColor;



func _on_Slot_pressed(slot):
	match slot:
		1: 
			if booleanSlotArray[0] == 0:			
				$Slot1.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[0] = 1;
				print(booleanSlotArray);												
			else:	
					if booleanSlotArray[0] != 0:
						$Slot1.texture_normal = emptySpace;					
						booleanSlotArray[0] = 0;								
		2: 
			if booleanSlotArray[1] == 0:			
				$Slot2.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[1] = 1;											
			else:	
					if booleanSlotArray[1] != 0:
						$Slot2.texture_normal = emptySpace;					
						booleanSlotArray[1] = 0;			
		3: 
			if booleanSlotArray[2] == 0:			
				$Slot3.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[2] = 1;											
			else:	
					if booleanSlotArray[2] != 0:
						$Slot3.texture_normal = emptySpace;					
						booleanSlotArray[2] = 0;	
		4: 
			if booleanSlotArray[3] == 0:			
				$Slot4.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[3] = 1;											
			else:	
					if booleanSlotArray[3] != 0:
						$Slot4.texture_normal = emptySpace;					
						booleanSlotArray[3] = 0;	
		5: 
			if booleanSlotArray[4] == 0:			
				$Slot5.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[4] = 1;											
			else:	
					if booleanSlotArray[4] != 0:
						$Slot5.texture_normal = emptySpace;					
						booleanSlotArray[4] = 0;
		6: 
			if booleanSlotArray[5] == 0:			
				$Slot6.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[5] = 1;											
			else:	
					if booleanSlotArray[5] != 0:
						$Slot6.texture_normal = emptySpace;					
						booleanSlotArray[5] = 0;
		7: 
			if booleanSlotArray[6] == 0:			
				$Slot7.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[6] = 1;											
			else:	
					if booleanSlotArray[6] != 0:
						$Slot7.texture_normal = emptySpace;					
						booleanSlotArray[6] = 0;
		8: 
			if booleanSlotArray[7] == 0:			
				$Slot8.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[7] = 1;											
			else:	
					if booleanSlotArray[7] != 0:
						$Slot8.texture_normal = emptySpace;					
						booleanSlotArray[7] = 0;
		9: 
			if booleanSlotArray[8] == 0:			
				$Slot9.texture_normal = _get_Fill_Color(1); #Set the texture to the player's color
				booleanSlotArray[8] = 1;											
			else:	
					if booleanSlotArray[8] != 0:
						$Slot9.texture_normal = emptySpace;					
						booleanSlotArray[8] = 0;			
