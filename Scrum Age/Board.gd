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
var knight_path = load("res://assets/Meeples/knight_head.png")

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

func addMeeples(index, amount):
	if(Global.meeple_counts[index]<Global.meeple_max[index]):
		Global.meeple_counts[index] += amount;
	else:
		print("Max meeple count reached, cannot add");
		
func subtractMeeples(index, amount):
	if(Global.meeple_counts[index]>Global.meeple_min):
		Global.meeple_counts[index] -= amount;
	else:
		print("Min meeple count reached, cannot subtract");
		
func updateMeepleLabels(label):
	$Players/HBoxContainer/MarginContainer/Player1/MeeplesLabel.Text = str(Global.meeple_counts[0]) + "/" + str(Global.meeple_max);

func touch_slot(grid_name, slot):
	var child = get_node(grid_name)
	if child.booleanSlotArray[slot-1] == 0:
			if (Global.meeple_counts[current_player] > 0):	
				set_meeple_color(grid_name+"/$Slot"+str(slot), current_player); #Set the texture to the player's color
				child.get_node("Slot"+str(slot)).texture_normal = knight_path
				child.booleanSlotArray[slot-1] = 1;
				subtractMeeples(current_player, 1);
				print(child.booleanSlotArray);
				print(Global.meeple_counts);
				$PlayerMenu.updateMeepleLabels();			
	else:
		if child.booleanSlotArray[slot-1] != 0:
			child.get_node("Slot"+str(slot)).texture_normal = emptySpace;
			child.booleanSlotArray[slot-1] = 0;
			addMeeples(current_player, 1);			
			print(Global.meeple_counts);		
			$PlayerMenu.updateMeepleLabels();		

