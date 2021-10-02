extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Start_pressed():
	Global.goto_scene("res://Board.tscn")


func _on_End_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_PlayerOne_text_changed(new_text):
	Global.playernameone = $VBoxContainer/VBoxContainer/PlayerOne.text


func _on_PlayerTwo_text_changed(new_text):
	Global.playernametwo= 	$VBoxContainer/VBoxContainer/PlayerTwo.text


func _on_PlayerThree_text_changed(new_text):
	Global.playernamethree = $VBoxContainer/VBoxContainer/PlayerThree.text


func _on_PlayerFour_text_changed(new_text):
	Global.playernamefour = $VBoxContainer/VBoxContainer/PlayerFour.text
	

func _on_PlayerFive_text_changed(new_text):
	Global.playernamefive = $VBoxContainer/VBoxContainer/PlayerFive.text

