extends MarginContainer

var nameArray = Global.player_names
var turnOrder = ["", "", "", "", ""]
var numPlayers = 5

func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	get_node("Players/HBoxContainer1/MarginContainer/Player1/TurnIndicatorP1").visible = true
	
	for i in range(0,5):
		if (nameArray[i] == ""):
			numPlayers = i
			break
	
	var first = random.randi_range(0, numPlayers - 1)
	
	for i in range(0, numPlayers):
		if (first + i > numPlayers - 1):
			turnOrder[first + i - numPlayers] = nameArray[i]
		else:
			turnOrder[first + i] = nameArray[i]

	get_node("Players/HBoxContainer1/MarginContainer/Player1/NameLabel").text = turnOrder[0]
	get_node("Players/HBoxContainer2/MarginContainer/Player2/NameLabel").text = turnOrder[1]
	get_node("Players/HBoxContainer3/MarginContainer/Player3/NameLabel").text = turnOrder[2]
	get_node("Players/HBoxContainer4/MarginContainer/Player4/NameLabel").text = turnOrder[3]
	get_node("Players/HBoxContainer5/MarginContainer/Player5/NameLabel").text = turnOrder[4]

func updateMeepleLabels(player):
	get_node("Players/HBoxContainer"+str(player)+"/MarginContainer/Player"+str(player)+"/MeeplesLabel").text = str(Global.meeple_counts[player-1]) + "/" + str(Global.meeple_max[player-1]);

func showTurn(player):
		get_node("Players/HBoxContainer"+str(player)+"/MarginContainer/Player"+str(player)+"/TurnIndicatorP"+str(player)).visible = true
		get_node("Players/HBoxContainer"+str(player-1)+"/MarginContainer/Player"+str(player-1)+"/TurnIndicatorP"+str(player-1)).visible = false
	
