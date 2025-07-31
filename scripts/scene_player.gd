extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for rootChild in get_tree().root.get_children():
		if(rootChild.name == "Main"):
			rootChild.pauseAudio()
			break
	Scores.checkIfWizardFound("a")

func _on_video_stream_player_finished() -> void:
	for rootChild in get_tree().root.get_children():
		if(rootChild.name == "Main"):
			rootChild.resumeAudio()
			break
	queue_free()
