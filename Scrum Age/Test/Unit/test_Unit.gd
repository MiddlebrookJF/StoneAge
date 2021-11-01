extends "res://addons/gut/test.gd"

#var Global = load("res://Global.gd");
#var Main = load("res://Main.gd");
#var _main = null;
var Player = load("res://PlayerMenu.gd");
var _player = null;
var Board = load("res://Board.gd")
var _board = null;
var slot = TextureButton.new()
var meeple_counts = [0]
var meeple_max = 3
var meeple_min = 0


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
	addMeeples(0, 1)
	assert_eq(meeple_counts[0], 1, "Should have been able to add a single meeple to value")
	meeple_counts[0] = 0


func test_addThree_Meeples_Pass():
	addMeeples(0, 3)		
	assert_eq(meeple_counts[0], 3, "Should have been able to add 3 to 0, and therefore pass")


	
func test_addTen_Meeples_Fail():
	addMeeples(0, 10)
	assert_lt(meeple_counts[0], 10, "Should not be able to add 10 because it is higher than meeple max")


func test_subtractThree_Meeples_Pass():
	subtractMeeples(0, 3)		
	assert_eq(meeple_counts[0], 0, "Should not be able to take 3 from 0, and therefore stay equal to 0")


	
func test_addTwenty_Meeples_Fail():
	addMeeples(0, 20)
	assert_lt(meeple_counts[0], 20, "Should not be able to add 20 because it is higher than meeple max")





func addMeeples(index, amount):
	if(meeple_counts[index]+amount <=meeple_max):
		meeple_counts[index] += amount;
	else:
		print("Max meeple count reached, cannot add");
		
func subtractMeeples(index, amount):
	if(meeple_counts[index]-amount >= meeple_min):
		meeple_counts[index] -= amount;	
	else:	
		print("Min meeple count reached, cannot subtract");
		

