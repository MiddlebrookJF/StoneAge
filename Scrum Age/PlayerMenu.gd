extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	var nameArray = [Global.playernameone, Global.playernametwo, Global.playernamethree, Global.playernamefour, Global.playernamefive]
	var turnOrder = ["", "", "", "", ""]
	var numPlayers = 5
	
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
	
	get_node("Players/P1 Container/PlayerOne").text = turnOrder[0]
	get_node("Players/P2 Container/PlayerTwo").text = turnOrder[1]
	get_node("Players/P3 Container/PlayerThree").text = turnOrder[2]
	get_node("Players/P4 Container/PlayerFour").text = turnOrder[3]
	get_node("Players/P5 Container/PlayerFive").text = turnOrder[4]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
