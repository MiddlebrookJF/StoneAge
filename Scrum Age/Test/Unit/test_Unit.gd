extends "res://addons/gut/test.gd"

# Variables used to load instances of each class
var Player = load("res://PlayerMenu.gd");
var _player = null;
var Board = load("res://Board.gd")
var _board = null;
var slot = TextureButton.new()
var panel = Panel.new()
var info = Label.new()

# Creates new instance values before each method
func before_each():
	_player = Player.new()
	_player.name = "PlayerMenu"
	_board = Board.new()
	add_child(_board)
	_board.add_child(_player)
	_board.name = "Board"
	self.name = "test"

# Deletes instance values to prevent memory leak
func after_each():
	_player.free();
	_board.free();

# Test to see if meeple color changes accordingly
func test_set_meeple_color_1_redcolor():
	slot.name = "slot"
	_board.add_child(slot)
	get_node("Board/slot").modulate = Color(1,0,1)
	print(get_node("Board/slot").name)
	_board.set_meeple_color("slot", 1)
	assert_eq(get_node("Board/slot").modulate, _board.red)

# Test to see if the player array can carry names
func test_player_array():
	_player.nameArray = ["Johhnn", "One", "AVEEEEEERRRRRRYYY", "trois", "4"];
	assert_eq(_player.nameArray[1], "One");

# Test to see if adding one meeple is possible
func test_addOne_Meeples_Pass():
	Global.meeple_counts[0] = 0
	_board.addMeeples(0, 1)
	assert_eq(Global.meeple_counts[0], 1, "Should have been able to add a single meeple to value")
	Global.meeple_counts[0] = 3

# Test to see if adding ten meeples is impossible
func test_addTen_Meeples_Fail():
	_board.addMeeples(0, 10)
	assert_lt(Global.meeple_counts[0], 10, "Should not be able to add 10 because it is higher than meeple max")

# Test to see if removing three meeples is possible
func test_subtractThree_Meeples_Pass():
	Global.meeple_counts[0] = 0
	_board.subtractMeeples(0, 3)
	assert_eq(Global.meeple_counts[0], 0, "Should not be able to take 3 from 0, and therefore stay equal to 0")
	Global.meeple_counts[0] = 3

# Test to see if the user can change players
func test_change_player():
	panel.name = "InfoPanel"
	info.name = "Info"
	_board.add_child(panel)
	panel.add_child(info)
	
	_board.end_Turn()
	assert_eq(_board.current_player, 2, "Player 2 not ready")
