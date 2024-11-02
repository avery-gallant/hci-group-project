extends TouchScreenButton
var music
var audio_loader
var image = Image.load_from_file("res://icon.svg")
var texture = ImageTexture.create_from_image(image)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	music = AudioStreamPlayer.new()
	audio_loader = AudioLoader.new()
	add_child(music)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	soundLoad()
	$Timer.start()

func soundLoad():
	music.set_stream(audio_loader.loadfile("souds/clap.wav"))
	music.volume_db = 1
	music.pitch_scale = 1
	music.play()


func _on_released():
	music.play()
