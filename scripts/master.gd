extends Node2D

var PLAYER = preload("res://scenes/player.tscn")
var MAIN_MENU = preload("res://scenes/main_menu.tscn")
var LEVEL = [
	preload("res://scenes/temp_level.tscn"),
	null,
	null,
	null,
	null
]
var PLAYER_SPAWN_POSITIONS = [
	Vector2(0, -100),
	Vector2(0, -100),
	Vector2(0, -100),
	Vector2(0, -100),
	Vector2(0, -100)
]

var camera_instance: Camera2D = null
var level_instance: Node2D = null
var player_instance: Node2D = null
var main_menu_instance: Control = null

var camera_target := Vector2(0, 0)
var camera_tzoom := Vector2(1, 1)
var level = 0

func load_level():
	camera_tzoom = Vector2(5, 5)
	remove_child(main_menu_instance)
	if player_instance == null:
		player_instance = PLAYER.instantiate()
		add_child(player_instance)
	player_instance.position = PLAYER_SPAWN_POSITIONS[level]
	if level_instance != null:
		remove_child(level_instance)
	level_instance = LEVEL[level].instantiate()
	add_child(level_instance)

func _ready() -> void:
	camera_instance = Camera2D.new()
	camera_instance.position = camera_target
	camera_instance.zoom = Vector2(0.1, 0.1)
	camera_tzoom = Vector2(1, 1)
	add_child(camera_instance)
	
	main_menu_instance = MAIN_MENU.instantiate()
	main_menu_instance.play.connect(load_level)
	add_child(main_menu_instance)

func _process(delta: float) -> void:
	camera_instance.position += (camera_target - camera_instance.position) / 10
	camera_instance.zoom += (camera_tzoom - camera_instance.zoom) / 10
	if player_instance != null:
		camera_target = player_instance.position
	print(camera_instance.zoom)
