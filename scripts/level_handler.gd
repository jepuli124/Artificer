extends Node3D

var level := 0

@onready var towerWindow = $Tower/window_center
@onready var level1Scene := preload("uid://dubej5xqlfdb1")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var levels = [level1Scene]
	var newLevel = levels[level].instantiate()
	newLevel.get_children()[0].window = towerWindow.global_position
	add_child(newLevel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
