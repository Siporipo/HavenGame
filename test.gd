extends Node2D

var BULLET := preload("res://scenes/bullet.tscn")
var bill = null

func _ready() -> void:
	bill = BULLET.instantiate()
	bill.speed = 60
	bill.direction = Vector2(1, 0)
	bill.position = Vector2(100, 100)
	bill.scale = Vector2(5, 5)
	add_child(bill)
