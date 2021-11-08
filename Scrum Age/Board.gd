extends Node2D

var current_player = 1;

const white = Color(1, 1, 1)
const red = Color(1, 0.262, 0.262)
const blue = Color(0.608, 0.651, 1)
const green = Color(0.227, 0.718, 0.377)
const yellow = Color(0.933, 0.988, 0.212)
const purple = Color(1, 0.110, 0.898)

# Called when the node enters the scene tree for the first time.
func _ready():
#	if(Global.meeple_counts[current_player]!=0):
		get_node("EndTurn").hide()
#	else:
#		get_node("EndTurn").show()
#	pass

var emptySpace = load("res://assets/EmptyBox.png")
var knight_path = load("res://assets/Meeples/knight_head.png")

#Get colored textures associated with each player, based on player value calling method (NEEDS TO BE UPDATED)
func set_meeple_color(texture_path, player):
	match player:
		0: get_node(texture_path).modulate = white
		1: get_node(texture_path).modulate = red
		2: get_node(texture_path).modulate = blue
		3: get_node(texture_path).modulate = green
		4: get_node(texture_path).modulate = yellow
		5: get_node(texture_path).modulate = purple

func addMeeples(index, amount):
	if(Global.meeple_counts[index]<Global.meeple_max[index]):
		Global.meeple_counts[index] += amount;
	else:
		print("Max meeple count reached, cannot add");
		
func subtractMeeples(index, amount):
	if(Global.meeple_counts[index]>Global.meeple_min):
		Global.meeple_counts[index] -= amount;
	else:
		print("Min meeple count reached, cannot subtract");

func touch_slot(grid_name, slot):
	var child = get_node(grid_name)
	#current_player-1 is used as index <== meeple_counts[] has player 1 at index 0
	if child.booleanSlotArray[slot-1] == 0:
			if (Global.meeple_counts[current_player-1] > 0):
				set_meeple_color(grid_name+"/Slot"+str(slot), current_player); #Set the texture to the player's color
				child.get_node("Slot"+str(slot)).texture_normal = knight_path #get knight icon
				child.booleanSlotArray[slot-1] = 1;		#show that the slot is now taken
				subtractMeeples(current_player-1, 1);
				print(Global.meeple_counts) 			#debug
				$PlayerMenu.updateMeepleLabels(current_player);
				if(Global.meeple_counts[current_player-1]==0):
					get_node("EndTurn").show()
				
				if(Global.meeple_counts[current_player-1]==1):
					get_node("HRGrid/Slot1").visible = false
					get_node("HRGrid/Slot2").visible = false

	else:
		if child.booleanSlotArray[slot-1] != 0:
			child.get_node("Slot"+str(slot)).texture_normal = emptySpace;	#remove knight texture
			set_meeple_color(grid_name+"/Slot"+str(slot), 0);
			child.booleanSlotArray[slot-1] = 0;
			addMeeples(current_player-1, 1);
			print(Global.meeple_counts);
			$PlayerMenu.updateMeepleLabels(current_player);
			if(Global.meeple_counts[current_player-1]!=0):
				get_node("EndTurn").hide()
			
			if(Global.meeple_counts[current_player-1]>1):
				get_node("HRGrid/Slot1").visible = true
				get_node("HRGrid/Slot2").visible = true
			
#called specifically to handle HR since it has slightly different properties to the other grids
#ERROR CHECK TO MAKE SURE PLAYER CANNOT CLICK HR IF 2 OTHER SLOTS ARE SELECTED
func touchHR_slot(grid_name,slot):
		var child = get_node(grid_name)
	#current_player-1 is used as index <== meeple_counts[] has player 1 at index 0
		if child.booleanSlotArray[slot-1] == 0:
			if (Global.meeple_counts[current_player-1] > 0):
				set_meeple_color(grid_name+"/Slot1", current_player); #Set the texture to the player's color
				set_meeple_color(grid_name+"/Slot2", current_player); 
				child.get_node("Slot1").texture_normal = knight_path #get knight icon
				child.get_node("Slot2").texture_normal = knight_path 
				child.booleanSlotArray[0] = 1;		#show that HR is taken
				child.booleanSlotArray[1] = 1;
				subtractMeeples(current_player-1, 2);
				print(Global.meeple_counts) 			#debug
				$PlayerMenu.updateMeepleLabels(current_player);
				if(Global.meeple_counts[current_player-1]==0):
					get_node("EndTurn").show()
	
		else:
			if child.booleanSlotArray[slot-1] != 0:
				set_meeple_color(grid_name+"/Slot1", 0); #Set the texture to the player's color
				set_meeple_color(grid_name+"/Slot2", 0); 
				child.get_node("Slot1").texture_normal = emptySpace #get knight icon
				child.get_node("Slot2").texture_normal = emptySpace
				child.booleanSlotArray[0] = 0;		#show that the slots are free
				child.booleanSlotArray[1] = 0;		
				addMeeples(current_player-1, 2);
				print(Global.meeple_counts);
				$PlayerMenu.updateMeepleLabels(current_player);
				if(Global.meeple_counts[current_player-1]!=0):
					get_node("EndTurn").hide()

func end_Turn():
	if(current_player < 5):
		current_player+=1
		$PlayerMenu.showTurn(current_player)
	else:
		current_player = 1
		#$PlayerMenu.showTurn(current_player)
	
	print("I ended!")
	get_node("EndTurn").hide()
	get_node("HRGrid/Slot1").visible = true
	get_node("HRGrid/Slot2").visible = true
