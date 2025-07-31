extends CharacterBody3D
class_name Donut_handler


var pickable := false
var follow := false
var SPEED := 20
var followSpeed := 100
var donutHolder : Marker3D
@onready var donut := preload("uid://r56acher5wec")
@onready var donutSpringle := preload("uid://dg25xh1ay5kqx")
@onready var donutSpringleBalls := preload("uid://cl38il8mar6t8")
@onready var viuh = $viuh
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chosenDonut = [donut, donutSpringle, donutSpringleBalls].pick_random()
	add_child(chosenDonut.instantiate())
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follow == true && donutHolder:
		var somevector = (donutHolder.global_position - global_position)
		if(somevector.length() > 1):
			somevector = somevector.normalized()
		velocity = velocity.move_toward(somevector * delta * SPEED * followSpeed, delta * SPEED)
			#global_position = global_position.move_toward(donutHolder.global_position, delta * SPEED)
	move_and_slide()


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1 && event.pressed == true):
			if(pickable):
				if not follow:
					follow = true
				else:
					viuh.play()
					follow = false
					velocity = (donutHolder.global_position - donutHolder.get_parent().global_position).normalized() * SPEED/10
			#get_mouse_position()
