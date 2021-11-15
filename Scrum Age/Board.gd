extends Node2D

var current_player = 1;		#1-based. eg player1 = 1, player5 = 5
var turnIndicator = 0
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
func resetMeepleCount():
	for i in Global.num_players:
		Global.meeple_counts[i]=Global.meeple_max[i]
		$PlayerMenu.updateMeepleLabels(i+1);
	
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
	if child.booleanSlotArray[slot-1] == -1:
		if (Global.meeple_counts[current_player-1] > 0):
			set_meeple_color(grid_name+"/Slot"+str(slot), current_player); #Set the texture to the player's color
			child.get_node("Slot"+str(slot)).texture_normal = knight_path #get knight icon
			child.booleanSlotArray[slot-1] = current_player-1;		#show that the slot is now taken
			print(child.booleanSlotArray);
			subtractMeeples(current_player-1, 1);
			print(Global.meeple_counts) 			#debug
			$PlayerMenu.updateMeepleLabels(current_player);
			if(Global.meeple_counts[current_player-1]==0):
				get_node("EndTurn").show()
			var hr = get_node("HRGrid")
			if(Global.meeple_counts[current_player-1]==1 && hr.booleanSlotArray[0] == -1):
				get_node("HRGrid/Slot1").visible = false
				get_node("HRGrid/Slot2").visible = false
		else:
			get_node("InfoPanel/Info").text = "You do not have enough Meeples"
			get_node("Timer").start();

	else:
		if child.booleanSlotArray[slot-1] == current_player -1:
			child.get_node("Slot"+str(slot)).texture_normal = emptySpace;	#remove knight texture
			set_meeple_color(grid_name+"/Slot"+str(slot), 0);
			child.booleanSlotArray[slot-1] = -1;
			addMeeples(current_player-1, 1);
			print(child.booleanSlotArray);
			print(Global.meeple_counts);
			$PlayerMenu.updateMeepleLabels(current_player);
			if(Global.meeple_counts[current_player-1]!=0):
				get_node("EndTurn").hide()
			
			if(Global.meeple_counts[current_player-1]>1):
				get_node("HRGrid/Slot1").visible = true
				get_node("HRGrid/Slot2").visible = true
		else:
			get_node("InfoPanel/Info").text = "Another player has meeples here."
			get_node("Timer").start();
#called specifically to handle HR since it has slightly different properties to the other grids
#ERROR CHECK TO MAKE SURE PLAYER CANNOT CLICK HR IF 2 OTHER SLOTS ARE SELECTED
func touchHR_slot(grid_name,slot):
		var child = get_node(grid_name)
	#current_player-1 is used as index <== meeple_counts[] has player 1 at index 0
		if child.booleanSlotArray[slot-1] == -1:
			if (Global.meeple_counts[current_player-1] > 0):
				set_meeple_color(grid_name+"/Slot1", current_player); #Set the texture to the player's color
				set_meeple_color(grid_name+"/Slot2", current_player); 
				child.get_node("Slot1").texture_normal = knight_path #get knight icon
				child.get_node("Slot2").texture_normal = knight_path 
				child.booleanSlotArray[0] = current_player-1;		#show that HR is taken
				child.booleanSlotArray[1] = current_player-1;
				get_node("HRGrid/Slot1").visible = true
				get_node("HRGrid/Slot2").visible = true
				subtractMeeples(current_player-1, 2);
				print(Global.meeple_counts) 			#debug
				$PlayerMenu.updateMeepleLabels(current_player);
				if(Global.meeple_counts[current_player-1]==0):
					get_node("EndTurn").show()
			else:
				get_node("InfoPanel/Info").text = "You do not have enough meeples."
				get_node("Timer").start();
		else:
			if child.booleanSlotArray[slot-1] == current_player -1:
				set_meeple_color(grid_name+"/Slot1", 0); #Set the texture to the player's color
				set_meeple_color(grid_name+"/Slot2", 0); 
				child.get_node("Slot1").texture_normal = emptySpace #get knight icon
				child.get_node("Slot2").texture_normal = emptySpace
				child.booleanSlotArray[0] = -1;		#show that the slots are free
				child.booleanSlotArray[1] = -1;		
				addMeeples(current_player-1, 2);
				print(Global.meeple_counts);
				$PlayerMenu.updateMeepleLabels(current_player);
				if(Global.meeple_counts[current_player-1]!=0):
					get_node("EndTurn").hide()
			else:
				get_node("InfoPanel/Info").text = "Another player has meeples here."
				get_node("Timer").start();
				
#Checks to see if the round is over by checking meeple counts
func round_check():
	for x in range(Global.num_players):
		if (Global.meeple_counts[x] != 0):
			return false
	return true

func newRound():
	clean_Board();
	get_node("InfoPanel/Info").text = "Round Over."
	get_node("Timer").start();
	turnIndicator = 0;
	
	if(Global.first_player < Global.num_players):
		Global.first_player+=1
	else:
		Global.first_player = 1
	
	current_player = Global.first_player

func end_Turn():
	if(current_player < Global.num_players):
		current_player+=1
	else:
		current_player = 1

	get_node("InfoPanel/Info").text = "SCRUM AGE"
	print("I ended!")
	turnIndicator+=1;
	
	if(round_check()):
		newRound();
		
	$PlayerMenu.showTurn(current_player)
	get_node("EndTurn").hide()
	get_node("HRGrid/Slot1").visible = true
	get_node("HRGrid/Slot2").visible = true
#cleans the board and returns meeples to players.
func clean_Board():
	for i in 9:
		get_node("DesignGrid/Slot"+str(i+1)).texture_normal = emptySpace
		get_node("DesignGrid").booleanSlotArray[i] = -1;
		set_meeple_color("DesignGrid"+"/Slot"+str(i+1), 0)
		get_node("ImpGrid/Slot"+str(i+1)).texture_normal = emptySpace
		get_node("ImpGrid").booleanSlotArray[i] = -1;
		set_meeple_color("ImpGrid"+"/Slot"+str(i+1), 0)
		get_node("RequirementsGrid/Slot"+str(i+1)).texture_normal = emptySpace
		get_node("RequirementsGrid").booleanSlotArray[i] = -1;
		set_meeple_color("RequirementsGrid"+"/Slot"+str(i+1), 0)
		get_node("TestingGrid/Slot"+str(i+1)).texture_normal = emptySpace
		get_node("TestingGrid").booleanSlotArray[i] = -1;
		set_meeple_color("TestingGrid"+"/Slot"+str(i+1), 0)
		get_node("TrainingGrid/Slot"+str(i+1)).texture_normal = emptySpace
		get_node("TrainingGrid").booleanSlotArray[i] = -1;
		set_meeple_color("TrainingGrid"+"/Slot"+str(i+1), 0)

	get_node("HRGrid/Slot1").texture_normal = emptySpace;
	get_node("HRGrid").booleanSlotArray[0] = -1;
	set_meeple_color("HRGrid"+"/Slot"+str(1), 0)
	get_node("HRGrid/Slot2").texture_normal = emptySpace;
	get_node("HRGrid").booleanSlotArray[1] = -1;
	set_meeple_color("HRGrid"+"/Slot"+str(2), 0)
	get_node("ToolGrid/Slot1").texture_normal = emptySpace;
	get_node("ToolGrid").booleanSlotArray[0] = -1;
	set_meeple_color("ToolGrid"+"/Slot"+str(1), 0)
	resetMeepleCount();

func _on_Timer_timeout():
	get_node("InfoPanel/Info").text = "Scrum Age"
