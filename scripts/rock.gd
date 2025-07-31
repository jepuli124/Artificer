extends CharacterBody3D
class_name Rock
var thrown : bool = false
var pickable := false
var SPEED := 20

signal picked
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	move_and_slide()

#func _on_area_3d_area_entered(area: Area3D) -> void:
#	var body = area.get_parent()
#	if(body is AbyssBlob and thrown):
#		body.queue_free()
#		queue_free()


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1 && event.pressed == true):
			if(pickable):
				picked.emit()
				queue_free()
