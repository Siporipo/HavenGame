extends CanvasLayer

@export var MainMenuBtn: Button
@export var ContinueBtn: Button

signal main_menu

func emit_main_menu() -> void:
	get_tree().paused = false
	main_menu.emit()

func unpause() -> void:
	get_tree().paused = false
	queue_free()

func _ready() -> void:
	MainMenuBtn.pressed.connect(emit_main_menu)
	ContinueBtn.pressed.connect(unpause)
	get_tree().paused = true
