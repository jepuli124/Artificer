extends Node3D

var level := Scores.currentLv - 1 

@onready var level1Scene := preload("uid://dubej5xqlfdb1")
@onready var level2Scene := preload("uid://dj8o7par3b40")
@onready var level3Scene := preload("uid://c1q71xyinpnfo")
@onready var level4Scene := preload("uid://0gn22qa8ngqa")

@onready var towerWindow = $Tower/window_center
@onready var GameOverCamera := $GameOverCamera
@onready var TowerCamera := $Tower/Camera3D
@onready var result := $GameOverCamera/Control/HBoxContainer/VBoxContainer/GameOver/VBoxContainer/result
@onready var stats := $GameOverCamera/Control/HBoxContainer/VBoxContainer/GameOver/VBoxContainer/stats

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
		$Timer.start(30 * Scores.currentLv)


func set_stats_and_results() -> void:
	result.text = Scores.endReason
	stats.text = "You served "+ str(Scores.currentScore) +" donuts\nYou banished " + str(Scores.abyssesBanished) + " Abysses"

func game_over() -> void:
	TowerCamera.visible = false
	TowerCamera.get_child(0).visible = false
	GameOverCamera.visible = true
	GameOverCamera.get_child(0).visible = true
	GameOverCamera.make_current()

func to_main_menu() -> void:
	for rootChild in get_tree().root.get_children():
		if(rootChild.name == "Main"):
			rootChild.change_scene("uid://dmcvnrd75u5mj")
			break

func _on_tower_lose() -> void:
	set_stats_and_results()
	game_over()
	Scores.write_score()


func _on_exit_pressed() -> void:
	to_main_menu()


func _on_timer_timeout() -> void:
	Scores.endReason = "Victory!"
	_on_tower_lose()
