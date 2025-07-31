extends Control

@onready var menu := $HBoxContainer/Menu
@onready var info := $HBoxContainer/Info
@onready var tutorial := $HBoxContainer/Tutorial
@onready var levels := $HBoxContainer/Levels
@onready var options := $HBoxContainer/Options
@onready var gameOver := $HBoxContainer/GameOver
@onready var wizardLabel := $HBoxContainer/Info/WizardCounter
@onready var ScoreLabel := $HBoxContainer/Info/ScoreLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_level_buttons()
	turn_all_off()
	menu.visible = true


func turn_all_off() -> void:
	menu.visible = false
	info.visible = false
	tutorial.visible = false
	levels.visible = false
	options.visible = false
	gameOver.visible = false

func create_level_buttons() -> void:
	var levelAmount := 4 if Scores.highestLV + 1 > 4 else Scores.highestLV + 1
	for x in range( levelAmount ):
		var newButton = Button.new()
		newButton.text = "level " + str(x+1)
		newButton.connect("pressed", to_level.bind(x+1))
		levels.add_child(newButton)

func to_level(level: int) -> void:
	Scores.currentLv = level
	for rootChild in get_tree().root.get_children():
		if(rootChild.name == "Main"):
			rootChild.change_scene("uid://bcv5vr6h2tsd1")
			break

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_tutorial_pressed() -> void:
	turn_all_off()
	Scores.checkIfWizardFound("t")
	tutorial.visible = true

func _on_return_from_info_pressed() -> void:
	turn_all_off()
	menu.visible = true


func _on_info_pressed() -> void:
	turn_all_off()
	Scores.checkIfWizardFound("i")
	wizardLabel.text = "You have found " + str(Scores.wizardsFound.length()) + " wizard(s)"
	ScoreLabel.text = "Most points: " + str(Scores.highScore) + "\nHighest Level completed: " + str(Scores.highestLV)
	info.visible = true


func _on_levels_pressed() -> void:
	turn_all_off()
	levels.visible = true


func _on_options_pressed() -> void:
	turn_all_off()
	Scores.checkIfWizardFound("o")
	options.visible = true
