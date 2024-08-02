extends Control
@onready var video_stream_player = $TextureRect/Panel/VideoStreamPlayer


func resume():
	get_tree().paused = false 
	$AnimationPlayer.play_backwards("blur")
	self.queue_free()
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
func _ready():
	$AnimationPlayer.play("RESET")
	pause()
	video_stream_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	


func _on_button_pressed():
	ButtonClick.button_click()
	video_stream_player.stop()
	resume()
