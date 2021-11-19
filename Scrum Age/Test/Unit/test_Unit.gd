extends "res://addons/gut/test.gd"

#var Main = load("res://Main.gd");
#var _main = null;
var Player = load("res://PlayerMenu.gd");
var _player = null;
var Board = load("res://Board.gd")
var _board = null;
var slot = TextureButton.new()
var panel = Panel.new()
var info = Label.new()

func before_each():
#	_main = Main.new()
	_player = Player.new()
	_player.name = "PlayerMenu"
	_board = Board.new()
	add_child(_board)
	_board.add_child(_player)
	_board.name = "Board"
	self.name = "test"

func after_each():
#	_main.free();
	_player.free();
	_board.free();

func test_set_meeple_color_1_redcolor():
	slot.name = "slot"
	_board.add_child(slot)
	get_node("Board/slot").modulate = Color(1,0,1)
	print(get_node("Board/slot").name)
	_board.set_meeple_color("slot", 1)
	assert_eq(get_node("Board/slot").modulate, _board.red)

func test_player_array():
	_player.nameArray = ["Johhnn", "One", "AVEEEEEERRRRRRYYY", "trois", "4"];
	assert_eq(_player.nameArray[1], "One");

func test_addOne_Meeples_Pass():
	Global.meeple_counts[0] = 0
	_board.addMeeples(0, 1)
	assert_eq(Global.meeple_counts[0], 1, "Should have been able to add a single meeple to value")
	Global.meeple_counts[0] = 3

func test_addTen_Meeples_Fail():
	_board.addMeeples(0, 10)
	assert_lt(Global.meeple_counts[0], 10, "Should not be able to add 10 because it is higher than meeple max")

func test_subtractThree_Meeples_Pass():
	Global.meeple_counts[0] = 0
	_board.subtractMeeples(0, 3)
	assert_eq(Global.meeple_counts[0], 0, "Should not be able to take 3 from 0, and therefore stay equal to 0")
	Global.meeple_counts[0] = 3

func test_change_player():
	panel.name = "InfoPanel"
	info.name = "Info"
	_board.add_child(panel)
	panel.add_child(info)
	
	_board.end_Turn()
	assert_eq(_board.current_player, 2, "Player 2 not ready")

#func test_board_wipe():
#	_board.clean_Board()
#	assert_eq(_board.get_node("DesignGrid").booleanSlotArray[0], -1, "Board not wiped")
