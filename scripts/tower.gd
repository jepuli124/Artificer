extends Node3D
class_name tower

@onready var camera := $Camera3D
@onready var donutSpawn := preload("uid://cquqy0vmrl7f5")
@onready var donutCollection := $DonutCollection
@onready var donutHolder := $Camera3D/DonutHolder

@export var SPEED := 1
var MOUSEMovement := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var input_dir := Input.get_axis("ui_right", "ui_left")
	if input_dir:
		camera.rotation.y = camera.rotation.y + input_dir * delta * SPEED
	elif MOUSEMovement:
		camera.rotation.y = camera.rotation.y + MOUSEMovement * delta * SPEED
		
func _on_area_2d_mouse_entered() -> void:
	MOUSEMovement = 1
	
func _on_area_2d_mouse_exited() -> void:
	MOUSEMovement = 0

func _on_area_2d_2_mouse_entered() -> void:
	MOUSEMovement = -1

func _on_area_2d_2_mouse_exited() -> void:
	MOUSEMovement = 0

func _generate_donut() -> void:
	var newDonut = donutSpawn.instantiate()
	newDonut.donutHolder = donutHolder
	newDonut.position = camera.position
	newDonut.rotation = Vector3(randf_range(0, TAU), randf_range(0, TAU), randf_range(0, TAU))
	newDonut.velocity += Vector3(randf_range(0.02, -0.1), randf_range(0.02, -0.02), randf_range(0.1, -0.1) ) * newDonut.SPEED
	donutCollection.add_child(newDonut)


func _on_donut_allow_area_body_exited(body: Node3D) -> void:
	if(body is Donut_handler):
		body.queue_free()

func _on_donut_wall_body_entered(body: Node3D) -> void:
	if(body is Donut_handler):
		body.velocity = Vector3(0, 0, 0)
		body.visible = true
		body.pickable = true
