extends Node2D

var PLAYER = preload("res://scenes/player.tscn")
var MAIN_MENU = preload("res://scenes/main_menu.tscn")
var PAUSE_MENU = preload("res://scenes/pause_overlay.tscn")
var LEVEL_MENU = preload("res://scenes/level_selection.tscn")
var LEVEL = [
	preload("res://scenes/levels/level_1.tscn"),
	preload("res://scenes/levels/level_2.tscn"),
	preload("res://scenes/levels/level_3.tscn"),
	preload("res://scenes/levels/level_4.tscn"),
	preload("res://scenes/levels/level_5.tscn"),
	preload("res://scenes/levels/level_7.tscn"),
	preload("res://scenes/levels/level_8.tscn"),
	preload("res://scenes/levels/level_9.tscn"),
	preload("res://scenes/levels/bossfight.tscn")
]
var PLAYER_SPAWN_POSITIONS = [
	Vector2(0, 0),
	Vector2(300, 200),
	Vector2(1800, 0),
	Vector2(2900, 50),
	Vector2(4100, 50),
	Vector2(375, 50),
	Vector2(525, 200),
	Vector2(675, 100),
	Vector2(1825, -310)
]

var camera_instance: Camera2D = null
var level_instance: Node2D = null
var player_instance: Node2D = null
var main_menu_instance: Control = null
var pause_menu_instance: CanvasLayer = null
var level_selection_menu: Control = null

var camera_target := Vector2(0, 0)
var camera_tzoom := Vector2(1, 1)

func load_level():
	level_selection_menu.queue_free()
	level_selection_menu = null
	if player_instance != null:
		player_instance.queue_free()
		player_instance = null
	player_instance = PLAYER.instantiate()
	player_instance.position = PLAYER_SPAWN_POSITIONS[Autoload.level-1]
	if level_instance != null:
		level_instance.queue_free()
		level_instance = null
	add_child(player_instance)
	level_instance = LEVEL[Autoload.level-1].instantiate()
	add_child(level_instance)

func load_level_selection():
	if player_instance != null:
		player_instance.queue_free()
		player_instance = null
	if level_instance != null:
		level_instance.queue_free()
		level_instance = null
	if pause_menu_instance != null:
		pause_menu_instance.queue_free()
		pause_menu_instance = null
		get_tree().paused = false
	if main_menu_instance != null:
		main_menu_instance.queue_free()
		main_menu_instance = null
	if level_selection_menu != null:
		level_selection_menu.queue_free()
		level_selection_menu = null
	level_selection_menu = LEVEL_MENU.instantiate()
	level_selection_menu.back_to_main_menu.connect(load_main_menu)
	level_selection_menu.load_level.connect(load_level)
	level_selection_menu.position = Vector2(get_viewport_rect().size.x / -2, get_viewport_rect().size.y / -2)
	add_child(level_selection_menu)

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
	if level_selection_menu != null:
		level_selection_menu.queue_free()
		level_selection_menu = null
	main_menu_instance = MAIN_MENU.instantiate()
	main_menu_instance.position.y = -60
	main_menu_instance.play.connect(load_level_selection)
	add_child(main_menu_instance)

func _ready() -> void:
	Autoload.level_done.connect(load_level_selection)
	camera_instance = Camera2D.new()
	camera_instance.position = camera_target
	camera_instance.zoom = Vector2(0.1, 0.1)
	camera_tzoom = Vector2(1, 1)
	add_child(camera_instance)
	
	load_main_menu()

func _process(_delta: float) -> void:
	if player_instance == null:
		Autoload.player_available = false
	else:
		Autoload.player_available = true
	if not get_tree().paused:
		camera_instance.position += (camera_target - camera_instance.position) / 10
		camera_instance.zoom += (camera_tzoom - camera_instance.zoom) / 10
	if player_instance != null:
		camera_target = player_instance.position
		camera_tzoom = Vector2(1.5, 1.5)
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
