extends Node3D

var level := Scores.currentLv - 1 
var startColor := Color(0.329, 0.563, 0.65)
var endColor := Color(0.272, 0.108, 0.0)
@onready var level1Scene := preload("uid://dubej5xqlfdb1")
@onready var level2Scene := preload("uid://dj8o7par3b40")
@onready var level3Scene := preload("uid://c1q71xyinpnfo")
@onready var level4Scene := preload("uid://0gn22qa8ngqa")

@onready var towerWindow = $Tower/window_center
@onready var GameOverCamera := $GameOverCamera
@onready var TowerCamera := $Tower/Camera3D
@onready var Tower := $Tower
@onready var result := $GameOverCamera/Control/HBoxContainer/VBoxContainer/GameOver/VBoxContainer/result
@onready var stats := $GameOverCamera/Control/HBoxContainer/VBoxContainer/GameOver/VBoxContainer/stats
@onready var enviroment := $WorldEnvironment
@onready var levelTimer := $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var levels = [level1Scene, level2Scene, level3Scene, level4Scene]
	var newLevel = levels[level].instantiate()
	newLevel.get_children()[0].window = towerWindow.global_position
	add_child(newLevel)
	TowerCamera.make_current()
	GameOverCamera.get_child(0).visible = false
	Scores.resetValues()
	if(Scores.currentLv != 4):
		levelTimer.start(30 * Scores.currentLv)

func _process(_delta: float) -> void:
	if(Scores.currentLv != 4):
		enviroment.environment.background_color = startColor.lerp(endColor, (30 * Scores.currentLv - levelTimer.time_left) / (30 * Scores.currentLv))

func set_stats_and_results() -> void:
	result.text = Scores.endReason
	stats.text = "You served "+ str(Scores.currentScore) +" donuts (not exactly, but it's your score)\nYou banished " + str(Scores.abyssesBanished) + " Abysses"

func game_over() -> void:
	TowerCamera.visible = false
	TowerCamera.get_child(0).visible = false
	GameOverCamera.visible = true
	GameOverCamera.get_child(0).visible = true
	GameOverCamera.make_current()

func to_main_menu() -> void:
	for rootChild in get_tree().root.get_children():
		if(rootChild.name == "Main"):
			rootChild.resetPitch()
			rootChild.change_scene("uid://dmcvnrd75u5mj")
			break

func _on_tower_lose() -> void:
	Tower.queue_free()
	set_stats_and_results()
	game_over()
	Scores.write_score()


func _on_exit_pressed() -> void:
	to_main_menu()


func _on_timer_timeout() -> void:
	Scores.endReason = "Victory!"
	_on_tower_lose()
