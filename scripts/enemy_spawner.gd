extends Node3D

var window : Vector3
@onready var client = preload("uid://4u5kldxqp2ga")
@onready var clientArray = $ClientArray
@onready var spawnPath = $Path3D/PathFollow3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if not window:
		return
	var newClient = client.instantiate()
	spawnPath.progress_ratio = randf()
	newClient.position = spawnPath.global_position
	newClient.window = window
	clientArray.add_child(newClient)
