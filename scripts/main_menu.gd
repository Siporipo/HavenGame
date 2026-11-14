extends Control

@export var playB: Button
@export var quitB: Button

signal quit
signal play

func emit_play():
	play.emit()

func emit_quit():
	get_tree().quit()

func _ready() -> void:
	playB.pressed.connect(emit_play)
	quitB.pressed.connect(emit_quit)
