extends Node2D

@onready var video := $VideoStreamPlayer

func _ready():
	video.finished.connect(_on_video_finished)
	video.play()

func _on_video_finished():
	get_tree().change_scene_to_file("res://ui/menu.tscn")


func _on_timer_timeout() -> void:
	pass # Replace with function body.
