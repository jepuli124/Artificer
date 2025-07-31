extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_scene("uid://dmcvnrd75u5mj") 

func change_scene(sceneName: String) -> void:
	remove_children()
	new_scene(sceneName)
	

func new_scene(x: String) -> void:
	var packedScene = load(x)
	var newScene = packedScene.instantiate()
	add_child(newScene)

func remove_children() -> void:
	for x in get_children():
		x.queue_free()
