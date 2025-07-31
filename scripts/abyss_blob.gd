extends CharacterBody3D
class_name AbyssBlob

var growthSpeed = 0.08
var SPEED := 20
var pickable := false
signal tooBig

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(pickable):
		scale += scale * growthSpeed * delta
		if(scale.x > 5.5):
			Scores.endReason = "Abyss consumed the tower..."
			tooBig.emit()
	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body is Donut_handler or body is Rock):
		body.queue_free()
	if(body is Rock and body.thrown):
		Scores.abyssesBanished += 1
		queue_free()
