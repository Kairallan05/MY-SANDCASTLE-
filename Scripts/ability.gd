extends Node2D
class_name Ability

var stage : int

func _init() -> void:
	stage = 0

func _level() -> void:
	stage += 1
