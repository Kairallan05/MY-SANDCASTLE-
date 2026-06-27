extends Node2D
class_name Ability

var stage : int
var Tutor_string : String
func _init() -> void:
	stage = 0

func _level() -> void:
	stage += 1
	
