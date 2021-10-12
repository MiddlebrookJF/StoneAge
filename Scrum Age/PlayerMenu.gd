extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Players/HBoxContainer/MarginContainer/NinePatchRect/PlayerOne").text = Global.playernameone
	get_node("Players/HBoxContainer2/MarginContainer/NinePatchRect/PlayerTwo").text = Global.playernametwo
	get_node("Players/HBoxContainer3/MarginContainer/NinePatchRect/PlayerThree").text = Global.playernamethree
	get_node("Players/HBoxContainer4/MarginContainer/NinePatchRect/PlayerFour").text = Global.playernamefour
	get_node("Players/HBoxContainer5/MarginContainer/NinePatchRect/PlayerFive").text = Global.playernamefive

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
