extends Node


var highestLV := 0
var highScore := 0
var wizardsFound := ""
var currentScore := 0
var currentLv := 0
var abyssesBanished := 0
var endReason := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("here")
	if(FileAccess.file_exists("user://highscore.txt")):
		var file = FileAccess.open("user://highscore.txt", FileAccess.READ)
		
		highestLV = int(file.get_line())
		highScore = int(file.get_line())
		wizardsFound = file.get_line()


func resetValues() -> void:
	currentScore = 0
	abyssesBanished = 0
	
func checkHighestValues() -> void:
	if(currentScore > highScore):
		highScore = currentScore
	if(currentLv > highestLV and endReason == "Victory!"):
		highestLV = currentLv

func checkIfWizardFound(wizardName: String) -> void:
	if(wizardName not in wizardsFound):
		wizardsFound += wizardName
		write_score()

func write_score() -> void:
	checkHighestValues()
	var file = FileAccess.open("user://highscore.txt", FileAccess.WRITE)
	file.store_string(str(highestLV, "\n", highScore, "\n", wizardsFound))
