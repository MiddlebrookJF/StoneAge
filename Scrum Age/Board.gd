extends Node2D

# Variables for current player and turn order
#var current_player = 1;		#1-based. eg player1 = 1, player5 = 5
var turnIndicator = 0

# Variables for meeple color
const white = Color(1, 1, 1)
const red = Color(1, 0.262, 0.262)
const blue = Color(0.608, 0.651, 1)
const green = Color(0.227, 0.718, 0.377)
const yellow = Color(0.933, 0.988, 0.212)
const purple = Color(1, 0.110, 0.898)

# Variables for the slots on a grid
var emptySpace = load("res://assets/EmptyBox.png")
var knight_path = load("res://assets/Meeples/knight_head.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#Get colored textures associated with each player, based on player value calling method (NEEDS TO BE UPDATED)
func set_meeple_color(texture_path, player):
	match player:
		0: get_node(texture_path).modulate = white
		1: get_node(texture_path).modulate = red
		2: get_node(texture_path).modulate = blue
		3: get_node(texture_path).modulate = green
		4: get_node(texture_path).modulate = yellow
		5: get_node(texture_path).modulate = purple

# Resets the meeple count to max
func resetMeepleCount():
	for i in Global.num_players:
		Global.meeple_counts[i]=Global.meeple_max[i]
		$PlayerMenu.updateMeepleLabels(i+1);

# Adds a meeplee to meeple count
func addMeeples(index, amount):
	if(Global.meeple_counts[index]<Global.meeple_max[index]):
		Global.meeple_counts[index] += amount;
	else:
		print("Max meeple count reached, cannot add");

# Subtracts a meeple from meeple count
func subtractMeeples(index, amount):
	if(Global.meeple_counts[index]>Global.meeple_min):
		Global.meeple_counts[index] -= amount;
	else:
		print("Min meeple count reached, cannot subtract");
func CheckCost(child):
	if Global.train_scores[Global.current_player-1] >= child.REQ[0] && Global.req_scores[Global.current_player-1] >= child.REQ[1] && Global.design_scores[Global.current_player-1] >= child.REQ[2] && Global.imp_scores[Global.current_player-1] >= child.REQ[3]:
		return true;
	else:
		get_node("InfoPanel/Info").text = "You do not have enough points "
		get_node("Timer").start();
		return false;
	

# Touch a slot to place or remove a meeple
func touch_slot(grid_name, slot):
	var child = get_node(grid_name)
		#current_player-1 is used as index <== meeple_counts[] has player 1 at index 0
	if child.booleanSlotArray[slot-1] == -1:
		if (Global.meeple_counts[Global.current_player-1] > 0):
			if CheckCost(child) == false:
				return;
			Global.train_scores[Global.current_player-1] -= child.REQ[0]
			$PlayerMenu.updateTraining(Global.current_player-1);
			Global.req_scores[Global.current_player-1] -= child.REQ[1]
			$PlayerMenu.updateReq(Global.current_player-1);
			Global.design_scores[Global.current_player-1] -= child.REQ[2]
			$PlayerMenu.updateDesign(Global.current_player-1);
			Global.imp_scores[Global.current_player-1] -= child.REQ[3]
			$PlayerMenu.updateImp(Global.current_player-1);
			set_meeple_color(grid_name+"/Slot"+str(slot), Global.current_player); #Set the texture to the player's color
			child.get_node("Slot"+str(slot)).texture_normal = knight_path #get knight icon
			child.booleanSlotArray[slot-1] = Global.current_player-1;		#show that the slot is now taken
			print(child.booleanSlotArray);
			subtractMeeples(Global.current_player-1, 1);
			print(Global.meeple_counts) 			#debug
			$PlayerMenu.updateMeepleLabels(Global.current_player);
		else:
			get_node("InfoPanel/Info").text = "You do not have enough Meeples"
			get_node("Timer").start();

	else:
		if child.booleanSlotArray[slot-1] == Global.current_player -1:
			Global.train_scores[Global.current_player-1] += child.REQ[0]
			$PlayerMenu.updateTraining(Global.current_player-1);
			Global.req_scores[Global.current_player-1] += child.REQ[1]
			$PlayerMenu.updateReq(Global.current_player-1);
			Global.design_scores[Global.current_player-1] += child.REQ[2]
			$PlayerMenu.updateDesign(Global.current_player-1);
			Global.imp_scores[Global.current_player-1] += child.REQ[3]
			$PlayerMenu.updateImp(Global.current_player-1);
			child.get_node("Slot"+str(slot)).texture_normal = emptySpace;	#remove knight texture
			set_meeple_color(grid_name+"/Slot"+str(slot), 0);
			child.booleanSlotArray[slot-1] = -1;
			addMeeples(Global.current_player-1, 1);
			print(child.booleanSlotArray);
			print(Global.meeple_counts);
			$PlayerMenu.updateMeepleLabels(Global.current_player);
		else:
			get_node("InfoPanel/Info").text = "Another player has meeples here."
			get_node("Timer").start();

#called specifically to handle HR since it has slightly different properties to the other grids
#ERROR CHECK TO MAKE SURE PLAYER CANNOT CLICK HR IF 2 OTHER SLOTS ARE SELECTED
func touchHR_slot(grid_name,slot):
		var child = get_node(grid_name)
	#current_player-1 is used as index <== meeple_counts[] has player 1 at index 0
		if child.booleanSlotArray[slot-1] == -1:
			if (Global.meeple_counts[Global.current_player-1] > 0):
				if CheckCost(child) == false:
					return;
				Global.train_scores[Global.current_player-1] -= child.REQ[0]
				$PlayerMenu.updateTraining(Global.current_player-1);
				Global.req_scores[Global.current_player-1] -= child.REQ[1]
				$PlayerMenu.updateReq(Global.current_player-1);
				Global.design_scores[Global.current_player-1] -= child.REQ[2]
				$PlayerMenu.updateDesign(Global.current_player-1);
				Global.imp_scores[Global.current_player-1] -= child.REQ[3]
				$PlayerMenu.updateImp(Global.current_player-1);
				set_meeple_color(grid_name+"/Slot1", Global.current_player); #Set the texture to the player's color
				set_meeple_color(grid_name+"/Slot2", Global.current_player); 
				child.get_node("Slot1").texture_normal = knight_path #get knight icon
				child.get_node("Slot2").texture_normal = knight_path 
				child.booleanSlotArray[0] = Global.current_player-1;		#show that HR is taken
				child.booleanSlotArray[1] = Global.current_player-1;
				get_node("HRGrid/Slot1").visible = true
				get_node("HRGrid/Slot2").visible = true
				subtractMeeples(Global.current_player-1, 2);
				print(Global.meeple_counts) 			#debug
				$PlayerMenu.updateMeepleLabels(Global.current_player);
			else:
				get_node("InfoPanel/Info").text = "You do not have enough meeples."
				get_node("Timer").start();
		else:
			if child.booleanSlotArray[slot-1] == Global.current_player -1:
				Global.train_scores[Global.current_player-1] += child.REQ[0]
				$PlayerMenu.updateTraining(Global.current_player-1);
				Global.req_scores[Global.current_player-1] += child.REQ[1]
				$PlayerMenu.updateReq(Global.current_player-1);
				Global.design_scores[Global.current_player-1] += child.REQ[2]
				$PlayerMenu.updateDesign(Global.current_player-1);
				Global.imp_scores[Global.current_player-1] += child.REQ[3]
				set_meeple_color(grid_name+"/Slot1", 0); #Set the texture to the player's color
				set_meeple_color(grid_name+"/Slot2", 0); 
				child.get_node("Slot1").texture_normal = emptySpace #get knight icon
				child.get_node("Slot2").texture_normal = emptySpace
				child.booleanSlotArray[0] = -1;		#show that the slots are free
				child.booleanSlotArray[1] = -1;		
				addMeeples(Global.current_player-1, 2);
				print(Global.meeple_counts);
				$PlayerMenu.updateMeepleLabels(Global.current_player);
			else:
				get_node("InfoPanel/Info").text = "Another player has meeples here."
				get_node("Timer").start();

# Resets turn order and increments the players
func newRound():
	upkeep();
	clean_Board();
	for i in 4:
		$PlayerMenu.updateScores(i);
	turnIndicator = 0;
	if(Global.round_counter >= 14):
		endGame();
	if(Global.first_player < Global.num_players):
		Global.first_player+=1
	else:
		Global.first_player = 1
	
	Global.current_player = Global.first_player

	# Problem, randomizer in PlayerMenu prevents this text from displaying the player names accurately
	# get_node("InfoPanel/Info").text = "Round Over. Player "+str(Global.player_names[Global.current_player-1])+"'s Turn! "
	get_node("InfoPanel/Info").text = "Round Over. Next Player's Turn! "
	Global.round_counter+=1
	$RoundPanel/Label/RoundNum.text = str(Global.round_counter+1)
	get_node("Timer").start();
	
func endGame():
	calculateWinner();
	$GameOver.show();
	
func calculateWinner():
	var winner = Global.player_score[0]
	var winnerpos = 0;
	for i in Global.player_score.size():
		if(Global.player_score[i]>winner):
			winner = Global.player_score[i]
			winnerpos = i
	if winner == 0:
		$GameOver/TextureRect/Panel/WinnerLabel.text = "It's a tie!"
	else:
		getWinnerColor(winnerpos);		

func getWinnerColor(pos):
	$GameOver/TextureRect/Panel/WinnerLabel.text = Global.player_names[pos] + " Wins! Congratulations!"

# Ends a turn and changes current player
func end_Turn():
	if(Global.current_player < Global.num_players):
		Global.current_player+=1
	else:
		Global.current_player = 1

	get_node("InfoPanel/Info").text = "SCRUM AGE"
	turnIndicator+=1;
	
	if(Global.current_player == Global.first_player):
		newRound()
	elif(Global.current_player - 1 == Global.num_players && Global.first_player == 1):
		newRound()
		
	$PlayerMenu.showTurn(Global.current_player)

func upkeep():
	var random = RandomNumberGenerator.new()
	for i in 9:
		if $TrainingGrid.booleanSlotArray[i] != -1:
			var playerID = $TrainingGrid.booleanSlotArray[i]
			random.randomize()
			var rolledVal = random.randi_range(1, 6)
			Global.train_scores[playerID]+= (rolledVal+Global.tool_bonus[playerID])*4;
			$PlayerMenu.updateTraining(playerID);
		if $RequirementsGrid.booleanSlotArray[i] != -1:
			var playerID = $RequirementsGrid.booleanSlotArray[i]
			random.randomize()
			var rolledVal = random.randi_range(1, 6)
			Global.req_scores[playerID]+= (rolledVal+Global.tool_bonus[playerID])*3;
			$PlayerMenu.updateReq(playerID);
		if $DesignGrid.booleanSlotArray[i] != -1:
			var playerID = $DesignGrid.booleanSlotArray[i]
			random.randomize()
			var rolledVal = random.randi_range(1, 6)
			Global.design_scores[playerID]+= (rolledVal+Global.tool_bonus[playerID])*3;
			$PlayerMenu.updateDesign(playerID);
		if $ImpGrid.booleanSlotArray[i] != -1:
			var playerID = $ImpGrid.booleanSlotArray[i]
			random.randomize()
			var rolledVal = random.randi_range(1, 6)
			Global.imp_scores[playerID]+= (rolledVal+Global.tool_bonus[playerID])*2;
			$PlayerMenu.updateImp(playerID);
		if $TestingGrid.booleanSlotArray[i] != -1:
			var playerID = $TestingGrid.booleanSlotArray[i]
			random.randomize()
			var rolledVal = random.randi_range(1, 6)
			Global.test_scores[playerID]+= (rolledVal+Global.tool_bonus[playerID]);
			$PlayerMenu.updateTest(playerID);
	var tools = $ToolGrid.booleanSlotArray[0]
	if tools != -1:
		Global.bTools[tools] =1;
		$PlayerMenu.showTool(tools)
	var HR = $HRGrid.booleanSlotArray[0]
	if HR != -1:
		Global.meeple_max[HR] += 1
		
	print("I survived")
	print(Global.train_scores)
	print(Global.req_scores)
	print(Global.design_scores)
	print(Global.imp_scores)
	print(Global.test_scores)	

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

# Resets the header text after timer runs out
func _on_Timer_timeout():
	get_node("InfoPanel/Info").text = "Scrum Age"


func ConvertStoryPoints():
	while Global.test_scores[Global.current_player-1] >= 10:
		Global.test_scores[Global.current_player-1]-=10
		$PlayerMenu.updateTest(Global.current_player-1);
		Global.player_score[Global.current_player-1]+=1;
		$PlayerMenu.updateScores(Global.current_player-1);


func use_Tool():
	if Global.bTools[Global.current_player-1] == 1:
		Global.tool_bonus[Global.current_player-1] += 10
		Global.bTools[Global.current_player-1] = 0
		$PlayerMenu.hideTool(Global.current_player-1)

func _on_GameOverButton_pressed():
	Global.ResetToDefault()
	Global.goto_scene("res://Main.tscn")
	Music.play_menu_music();
