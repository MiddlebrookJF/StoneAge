extends "res://addons/gut/test.gd"

#var Global = load("res://Global.gd");
var Music = load("res://Music.gd");
var _music = null;

func before_each():
	_music = Music.new();

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
	var result = _music.some_method();
	
	assert_eq(result, "apples", "Test does not work");
