extends MarginContainer

# Variables 
var nameArray = Global.player_names
var turnOrder = ["", "", "", "", ""]
var numPlayers = 5

# Randomizes the players based on current number of players
func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	get_node("Players/HBoxContainer1/MarginContainer/Player1/TurnIndicatorP1").visible = true
	
	for i in range(0, 5):
		if (nameArray[i] == ""):
			nameArray[i] = "Player " + str(i+1)
	
	numPlayers = Global.num_players
	
	var first = random.randi_range(0, numPlayers - 1)
	
	for i in range(0, numPlayers):
		if (first + i > numPlayers - 1):
			turnOrder[first + i - numPlayers] = nameArray[i]
		else:
			turnOrder[first + i] = nameArray[i]
	
	for i in range(0,5):
		if i < numPlayers:
			get_node("Players/HBoxContainer"+str(i+1)+"/MarginContainer/Player"+str(i+1)+"/NameLabel").text = turnOrder[i]
		else:
			get_node("Players/HBoxContainer"+str(i+1)+"/MarginContainer/Player"+str(i+1)).visible = false

# Updates the meeple counts for each player
func updateMeepleLabels(player):
	get_node("Players/HBoxContainer"+str(player)+"/MarginContainer/Player"+str(player)+"/MeeplesLabel").text = str(Global.meeple_counts[player-1]) + "/" + str(Global.meeple_max[player-1]);

func updateScores(player):
	get_node("Players/HBoxContainer"+str(player+1)+"/MarginContainer/Player"+str(player+1)+"/ScoreLabel").text = str(Global.player_score[player]);
# Removes the flag next to each player
func clearFlags():
	for x in range(1, 6):
		get_node("Players/HBoxContainer"+str(x)+"/MarginContainer/Player"+str(x)+"/TurnIndicatorP"+str(x)).visible = false

# Places the flag next to the player during their turn
func showTurn(player):
	clearFlags()
	get_node("Players/HBoxContainer"+str(player)+"/MarginContainer/Player"+str(player)+"/TurnIndicatorP"+str(player)).visible = true
