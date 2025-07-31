extends Node3D

var window : Vector3
@onready var client = preload("uid://4u5kldxqp2ga")
@onready var clientArray = $ClientArray
@onready var spawnPath = $Path3D/PathFollow3D
@onready var ClientTimer = $ClientTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ClientTimer.start(10.0/(Scores.currentLv/2.0 + 1))


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
