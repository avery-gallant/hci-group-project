extends TouchScreenButton

var on = false
var c = Image.load_from_file("res://texture/garbage.png"); 
var d = Image.load_from_file("res://texture/open_garb.png");
var closed_texture = ImageTexture.create_from_image(c); 
var open_texture = ImageTexture.create_from_image(d);
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_normal = closed_texture
	texture_pressed = closed_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_released() -> void:
	on=!on
	if (on):
		get_parent().get_node("background").texture = load("res://texture/background_dark.png")
		texture_normal = open_texture
		texture_pressed = open_texture
	else:
		get_parent().get_node("background").texture = load("res://texture/background.png")
		texture_normal = closed_texture
		texture_pressed = closed_texture
