extends Node3D
class_name Client

var inline := false
var window : Vector3
var velocity: Vector3 = Vector3(0, 0, 0)
var SPEED := 2
var rotateBool := false



signal donutEaten
signal rocked
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#look_at((window - global_position))
	if(randf() > 0.50):
		rotateBool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var somevector = (window - global_position).normalized()
	if abs(somevector.y) > 0.1:
		somevector.x = 0
		somevector.z = 0
	velocity = somevector * SPEED * delta
	global_position += velocity
	if(rotateBool):
		rotation.y += delta * SPEED
	
func set_target_position(target: Vector3) -> void:
	window = target

func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body is Donut_handler && inline):
		donutEaten.emit()
		queue_free()
		body.queue_free()
	if(body is Rock):
		rocked.emit()
		queue_free()
		body.queue_free()
