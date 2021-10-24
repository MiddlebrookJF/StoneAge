extends Node

var menu_theme = load("res://assets/The Elder Scrolls IV - Oblivion.mp3")
var board_theme = load("res://assets/The_Witcher_3__Wild_Hunt_Soundtrack_-_Gwent_Full_Mix.mp3")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_menu_music():
	$Music.stream = menu_theme
	$Music.play()

func play_board_music():
	$Music.stream = board_theme
	$Music.play()


