extends Node2D

var PLAYER = preload("res://scenes/player.tscn")
var MAIN_MENU = preload("res://scenes/main_menu.tscn")
var PAUSE_MENU = preload("res://scenes/pause_overlay.tscn")
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
var pause_menu_instance: CanvasLayer = null

var camera_target := Vector2(0, 0)
var camera_tzoom := Vector2(1, 1)
var level = 0

func load_level():
	main_menu_instance.queue_free()
	main_menu_instance = null
	if player_instance == null:
		player_instance = PLAYER.instantiate()
		add_child(player_instance)
	player_instance.position = PLAYER_SPAWN_POSITIONS[level]
	if level_instance != null:
		level_instance.queue_free()
		level_instance = null
	level_instance = LEVEL[level].instantiate()
	add_child(level_instance)

func load_main_menu() -> void:
	if player_instance != null:
		player_instance.queue_free()
		player_instance = null
	if level_instance != null:
		level_instance.queue_free()
		level_instance = null
	if pause_menu_instance != null:
		pause_menu_instance.queue_free()
		pause_menu_instance = null
	main_menu_instance = MAIN_MENU.instantiate()
	main_menu_instance.position.y = -60
	main_menu_instance.play.connect(load_level)
	add_child(main_menu_instance)

func _ready() -> void:
	camera_instance = Camera2D.new()
	camera_instance.position = camera_target
	camera_instance.zoom = Vector2(0.1, 0.1)
	camera_tzoom = Vector2(1, 1)
	add_child(camera_instance)
	
	load_main_menu()

func _process(delta: float) -> void:
	if not get_tree().paused:
		camera_instance.position += (camera_target - camera_instance.position) / 10
		camera_instance.zoom += (camera_tzoom - camera_instance.zoom) / 10
	if player_instance != null:
		camera_target = player_instance.position
		camera_tzoom = Vector2(5, 5)
	else:
		camera_target = Vector2(0, 0)
		camera_tzoom = Vector2(1, 1)
	if Input.is_action_just_pressed("ui_close_dialog"):
		if main_menu_instance == null:
			if not pause_menu_instance:
				pause_menu_instance = PAUSE_MENU.instantiate()
				pause_menu_instance.main_menu.connect(load_main_menu)
				add_child(pause_menu_instance)
			else:
				pause_menu_instance.queue_free()
				pause_menu_instance = null
				get_tree().paused = false
