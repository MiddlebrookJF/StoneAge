extends "res://addons/gut/test.gd"

#var Global = load("res://Global.gd");
var Main = load("res://Main.gd");
var _main = null;
var Player = load("res://PlayerMenu.gd");
var _player = null;

func before_each():
	#main = Main.new();
	_player = Player.new()

func after_each():
	_main.free();
	_player.free();

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

func test_player_array():
	_player.nameArray = ["Johhnn", "FuckAssBoiven" , "AVEEEEEERRRRRRYYY", "Edwad" ,"god"];
	
	assert_eq(_player.nameArray[1], "you");
