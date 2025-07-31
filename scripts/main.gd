extends Node

@onready var theme := $AudioStreamPlayer 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_scene("uid://dmcvnrd75u5mj") 
	theme.play()

func change_scene(sceneName: String) -> void:
	remove_children()
	new_scene(sceneName)
	

func new_scene(x: String) -> void:
	var packedScene = load(x)
	var newScene = packedScene.instantiate()
	add_child(newScene)

func remove_children() -> void:
	for x in get_children():
		if(x.name != "AudioStreamPlayer"):
			x.queue_free()

func resetPitch() -> void:
	theme.pitch_scale = 1
	
func set_pitch(value: float) -> void:
	theme.pitch_scale = value

func pauseAudio():
	theme.stop()
	
func resumeAudio():
	theme.play()
