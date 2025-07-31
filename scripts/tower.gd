extends Node3D
class_name tower

@onready var camera := $Camera3D
@onready var donutSpawn := preload("uid://cquqy0vmrl7f5")
@onready var rock := preload("uid://dh3m5dgf6y44p")
@onready var abyssBlob := preload("uid://drctnfwlg17no")
@onready var donutCollection := $DonutCollection
@onready var rockCollection := $RockCollection
@onready var abyssCollection := $AbyssColection
@onready var donutHolder := $Camera3D/DonutHolder
@onready var line := $Line
@onready var inlinePeople := $InlinePeople
@onready var rockLabel := $Camera3D/Control/Label
var inlineMethods : Array = []

@export var SPEED := 1
var MOUSEMovement := 0
var ROCKamount := 0
signal lose
signal order 

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

func throw_at_wall_parameters(body) -> void:
	body.position = camera.position
	body.rotation = Vector3(randf_range(0, TAU), randf_range(0, TAU), randf_range(0, TAU))
	body.velocity += Vector3(randf_range(0.02, -0.1), randf_range(0.01, -0.01), randf_range(0.1, -0.1) ) * body.SPEED

func _generate_donut() -> void:
	var newDonut = donutSpawn.instantiate()
	newDonut.donutHolder = donutHolder
	throw_at_wall_parameters(newDonut)
	donutCollection.add_child(newDonut)


func _on_donut_allow_area_body_exited(body: Node3D) -> void:
	if(body is Donut_handler || body is Rock):
		body.queue_free()

func _on_donut_wall_body_entered(body: Node3D) -> void:
	if(body is Donut_handler || body is AbyssBlob || body is Rock):
		body.velocity = Vector3(0, 0, 0)
		body.visible = true
		body.pickable = true
		if(body is AbyssBlob and body.tooBig.get_connections().size() == 0):
			body.tooBig.connect(lose.emit)


#func _on_enter_line_body_entered(body: Node3D) -> void:
#	print(body)
#	if(body is Client):
#		if(body.inline == false):
#			var followLine = PathFollow3D
#			var childcount = line.get_child_count()
#			if(childcount >= 6):
#				lose.emit()
#			line.add_child(followLine)
#			followLine.progress_ratio = 6-childcount/6.0
#			body.inline = true
#			print(followLine.global_position)
#			body.set_target_position(followLine.global_position)

func line_fix() -> void:
	var paths = line.get_children()
	#var clientsInline = inlinePeople.get_children()
	paths[0].queue_free()
	
	for x in range(1, paths.size()):
		paths[x].progress_ratio = (7-x)/6.0
		inlineMethods[x].call(paths[x].global_position)
	inlineMethods.remove_at(0)
	
func orderDone() -> void:
	Scores.currentScore += 1
	order.emit()
	line_fix()


func client_rocked() -> void:
	Scores.currentScore -= 2
	line_fix()

func _on_enter_line_area_entered(area: Area3D) -> void:
	var body = area.get_parent()
	if(body is Client):
		if(body.inline == false):
			var followLine = PathFollow3D.new()
			var childcount = line.get_child_count()
			if(childcount >= 6):
				Scores.endReason = "Clients patience run out. They destroyed your tower!"
				lose.emit()
			line.add_child(followLine)
			followLine.progress_ratio = 6-childcount/6.0
			body.inline = true
			body.connect("donutEaten", orderDone)
			body.connect("rocked", client_rocked)
			body.set_target_position(followLine.global_position)
			inlineMethods.append(body.set_target_position)


func _on_rock_timer_timeout() -> void:
	if(randf() > 0.25):
		var newRock = rock.instantiate()
		throw_at_wall_parameters(newRock)
		newRock.connect("picked", add_rock)
		newRock.visible = false
		rockCollection.add_child(newRock)
	else:
		var newAbyss = abyssBlob.instantiate()
		throw_at_wall_parameters(newAbyss)
		abyssCollection.add_child(newAbyss)

func add_rock():
	ROCKamount += 1
	changeRockLabel()

func can_throw_rock():
	if(ROCKamount > 0):
		ROCKamount -= 1
		changeRockLabel()
		return true
	return false
	
func changeRockLabel():
	rockLabel.text = "Amount of rocks: " + str(ROCKamount)


func _on_area_2d_3_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if(event.button_mask == 2 and event.is_pressed()):
		if(can_throw_rock()):
			var newRock = rock.instantiate()
			newRock.position = camera.global_position
			newRock.velocity = camera.project_ray_normal(event.position).normalized() * 1.2
			newRock.thrown = true
			newRock.visible = true
			rockCollection.add_child(newRock)
