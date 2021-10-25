extends Node2D

var current_player = 0

const red = Color(1, 0.262, 0.262)
const blue = Color(0.608, 0.651, 1)
const green = Color(0.227, 0.718, 0.377)
const yellow = Color(0.933, 0.988, 0.212)
const purple = Color(1, 0.110, 0.898)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var emptySpace = load("res://assets/EmptyBox.png")
var knight_path = load("res://assets/Meeples/head.png")

#Get colored textures associated with each player, based on player value calling method (NEEDS TO BE UPDATED)
func set_meeple_color(texture_path, player):
	match player:
		0: return emptySpace
		1: get_node(texture_path).modulate = red
		2: get_node(texture_path).modulate = blue
		3: get_node(texture_path).modulate = green
		4: get_node(texture_path).modulate = yellow
		5: get_node(texture_path).modulate = purple
	return knight_path;

func touch_slot(grid_name, slot):
	var child = get_node(grid_name)
	if child.booleanSlotArray[slot-1] == 0:
		set_meeple_color(grid_name+"/$Slot"+slot, current_player); #Set the texture to the player's color
		child.get_node("Slot"+slot).texture_normal = knight_path
		child.booleanSlotArray[slot-1] = 1;
		print(child.booleanSlotArray);
	else:
		if child.booleanSlotArray[slot-1] != 0:
			child.get_node("Slot"+slot).texture_normal = emptySpace;
			child.booleanSlotArray[slot-1] = 0;
