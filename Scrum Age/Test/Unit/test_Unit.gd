extends "res://addons/gut/test.gd"

#var Global = load("res://Global.gd");
#var Main = load("res://Main.gd");
#var _main = null;
var Player = load("res://PlayerMenu.gd");
var _player = null;
var Board = load("res://Board.gd")
var _board = null;
var slot = TextureButton.new()

func before_each():
#	_main = Main.new()
	_player = Player.new()
	_board = Board.new()
	add_child(_board)
	_board.name = "Board"
	self.name = "test"

func after_each():
#	_main.free();
	_player.free();
	_board.free();
	slot.free()

func test_set_meeple_color_1_redcolor():
	_board.add_child(slot)
	slot.name = "slot"
	get_node("Board/slot").modulate = Color(1,0,1)
	print(get_node("Board/slot").name)
	_board.set_meeple_color("slot", 1)
	assert_eq(get_node("Board/slot").modulate, _board.red)

func test_player_array():
	_player.nameArray = ["Johhnn", "One", "AVEEEEEERRRRRRYYY", "trois", "4"];
	
	assert_eq(_player.nameArray[1], "One");
