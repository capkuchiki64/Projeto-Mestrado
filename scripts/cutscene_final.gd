extends Node2D

@onready var video: VideoStreamPlayer = $VideoStreamPlayer

func _on_video_finished() -> void:
	get_tree().change_scene_to_file("res://ui/menu.tscn")

func _ready() -> void:
	video.finished.connect(_on_video_finished)
	video.play()
