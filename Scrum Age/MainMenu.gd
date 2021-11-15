extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Music.play_menu_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Start_pressed():
	Global.num_players = get_node("VBoxContainer/NumPlayersContainer/VBoxContainer/NumPlayersSpinBox").value
	Global.goto_scene("res://Board.tscn")
	Music.play_board_music()


func _on_End_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_PlayerOne_text_changed(new_text):
	Global.player_names[0] = $VBoxContainer/LineEditsContainer/PlayerOne.text


func _on_PlayerTwo_text_changed(new_text):
	Global.player_names[1]= 	$VBoxContainer/LineEditsContainer/PlayerTwo.text


func _on_PlayerThree_text_changed(new_text):
	Global.player_names[2] = $VBoxContainer/LineEditsContainer/PlayerThree.text


func _on_PlayerFour_text_changed(new_text):
	Global.player_names[3] = $VBoxContainer/LineEditsContainer/PlayerFour.text
	

func _on_PlayerFive_text_changed(new_text):
	Global.player_names[4] = $VBoxContainer/LineEditsContainer/PlayerFive.text

func _on_SpinBox_value_changed(value):
	Global.num_players = value
	if value == 2:
		$VBoxContainer/LineEditsContainer/PlayerThree.set_visible(false)
		$VBoxContainer/LineEditsContainer/PlayerThree.text = ""
		Global.player_names[2] = ""
		$VBoxContainer/LineEditsContainer/PlayerFour.set_visible(false)
		$VBoxContainer/LineEditsContainer/PlayerFour.text = ""
		Global.player_names[3] = ""
		$VBoxContainer/LineEditsContainer/PlayerFive.set_visible(false)
		$VBoxContainer/LineEditsContainer/PlayerFive.text = ""
		Global.player_names[4] = ""
	elif value == 3:
		$VBoxContainer/LineEditsContainer/PlayerThree.set_visible(true)
		$VBoxContainer/LineEditsContainer/PlayerFour.set_visible(false)
		$VBoxContainer/LineEditsContainer/PlayerFour.text = ""
		Global.player_names[3] = ""
		$VBoxContainer/LineEditsContainer/PlayerFive.set_visible(false)
		$VBoxContainer/LineEditsContainer/PlayerFive.text = ""
		Global.player_names[4] = ""
	elif value == 4:
		$VBoxContainer/LineEditsContainer/PlayerThree.set_visible(true)
		$VBoxContainer/LineEditsContainer/PlayerFour.set_visible(true)
		$VBoxContainer/LineEditsContainer/PlayerFive.set_visible(false)
		$VBoxContainer/LineEditsContainer/PlayerFive.text = ""
		Global.player_names[4] = ""
	elif value == 5:
		$VBoxContainer/LineEditsContainer/PlayerThree.set_visible(true)
		$VBoxContainer/LineEditsContainer/PlayerFour.set_visible(true)
		$VBoxContainer/LineEditsContainer/PlayerFive.set_visible(true)
