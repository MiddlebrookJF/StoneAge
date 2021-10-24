extends "res://addons/gut/test.gd"

#var Global = load("res://Global.gd");
var Main = load("res://Main.gd");
var _main = null;

func before_each():
	_main = Main.new();

func after_each():
	pass;

#func test_scene_change():
#	var _global = Global.new();
#	var result = _global.goto_scene("res://Board.tscn");
#	
#	assert_true(result == "res://MainMenu.tscn", "Supposed to be board scene");

#func test_music():
#	var _music = Music.new();
#	var menu_theme = _music.play_menu_music();
#	
#	assert_true(menu_theme == "res://assets/The Elder Scrolls IV - Oblivion.mp3", "Supposed to play menu theme");

func test_some_method():
	var result = _main.get_node("Board").some_method();
	 
	assert_eq(result, "apples", "Test does not work (just for testing out the GUT extension)");
