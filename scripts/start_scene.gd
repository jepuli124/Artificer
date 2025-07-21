extends Node3D

var timerCount = 10
@onready var client = preload("uid://4u5kldxqp2ga")
@onready var objectArray = $objectArray
@onready var spawnPath = $Path3D/PathFollow3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	var newClient = client.instantiate()
	spawnPath.progress_ratio = randf()
	newClient.position = spawnPath.global_position
	newClient.window = spawnPath.global_position
	newClient.window.y -= 5 
	newClient.rotateBool = true
	objectArray.add_child(newClient)
	if(timerCount <= 0):
		$Timer.stop()
	timerCount -= 1
