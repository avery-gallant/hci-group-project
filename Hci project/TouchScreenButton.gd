extends TouchScreenButton
var music
var audio_loader
@onready var fd_get = $FileDialog
# Called when the node enters the scene tree for the first time.
func _ready():
	fd_get.visible=false
	music = AudioStreamPlayer.new()
	audio_loader = AudioLoader.new()
	add_child(music)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	$Timer.start()
	music.play()

func _on_released():
	$Timer.stop()	

func _on_timer_timeout():
	visible=false
	fd_get.visible=true
	visible=true

func _on_file_dialog_file_selected(path):
	fd_get.visible=false
	music.set_stream(audio_loader.loadfile(path))
	music.volume_db = 1
	music.pitch_scale = 1
