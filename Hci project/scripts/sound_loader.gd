extends Node2D

var dir
@export var path : String

@export var ringRadius : float
@export var buttonRadius : int
@export var maxRow : int
@export var spacing : float
@export var colour : Color

var numButtons

var xCoord = 0
var yCoord = 0

var music
var audioLoader

signal loadSound

func _ready():
	await get_parent().get_parent()._ready()
	colour = get_parent().colour
	$bigButton/CollisionShape2D.shape.radius = 5.5*ringRadius
	visible = false
	scanFile()
	placeButtons()
	
	music = AudioStreamPlayer.new()
	add_child(music)
	audioLoader = AudioLoader.new()
	
func scanFile():
	dir = DirAccess.open(path)
	dir.list_dir_begin()
	var i = 0
	var file = dir.get_next()
	while file != "":
		var button = Area2D.new()
		button.name = file
		
		var bg = Sprite2D.new()
		bg.scale = Vector2(1, 1)
		bg.texture = load("res://texture/white_circle.png")
		button.add_child(bg)
		
		var shape = CollisionShape2D.new()
		shape.name = "shape"
		shape.shape = CircleShape2D.new()
		shape.z_index = 4
		button.add_child(shape)
		
		var text = Label.new()
		text.name = "text"
		text.text = button.name.replace("_wav", "")
		
		var lum = colour.get_luminance()
		print(lum)
		if(lum > 160):
			text.add_theme_color_override("font_color", Color(0, 0, 0,))
		else:
			text.add_theme_color_override("font_color", Color(255, 255, 255))
		#var style = StyleBoxFlat.new()
		#style.bg_color = Color(1, 1, 1)
		#text.add_theme_stylebox_override("normal", style)
		text.add_theme_font_override("font", load("res://fonts/courbd.ttf"))
		text.add_theme_font_size_override("font_size", 25)
		text.set("z_index", 1)
		button.add_child(text)
		
		button.mouse_entered.connect(onEntered.bind(button.name))
		button.mouse_exited.connect(onReleased.bind(button.name, i))
		
		var texture = load("res://texture/soundloader_button.png"); 
		var sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.modulate = colour
		button.add_child(sprite)
		
		$buttons.add_child(button)
		
		file = dir.get_next()
		file = dir.get_next()
		i += 1
	dir.list_dir_end()

func placeButtons():
	numButtons = $buttons.get_child_count()
	var theta = PI/min(numButtons+1, maxRow+1)
	var i = 0
	while(theta < PI):
		placeOnCircle(ringRadius, theta, i)
		theta += PI/min(numButtons+1, maxRow+1)
		i += 1
	
	if(numButtons > maxRow):
		ringRadius = 1.5*ringRadius
		theta = PI/(numButtons - maxRow + 1)
		i = maxRow
		while(theta < PI):
			placeOnCircle(ringRadius, theta, i)
			theta += PI/(numButtons - maxRow + 1)
			i += 1

func placeOnCircle(radius : float, theta: float, i: int):
	$buttons.get_child(i).get_node("shape").shape.radius = buttonRadius
	$buttons.get_child(i).get_node("text").position = -$buttons.get_child(i).get_node("text").size/2
	var c = 1
	if(get_parent().get_index() > 7):
		c = -1
	$buttons.get_child(i).position.x = c*radius*cos(theta)
	$buttons.get_child(i).position.y = c*radius*sin(theta)
	
func onReleased(name : String, i: int):
	if(!visible):
		var file = path + name.replace("_", ".")
		loadSound.emit(file)
		get_parent().self_modulate = colour
		
func onEntered(name: String):
	var file = path + name.replace("_", ".")
	music.set_stream(audioLoader.loadfile(file))
	music.volume_db = 1
	music.pitch_scale = 1
	music.play()
	
func _on_big_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event is InputEventScreenTouch): 
		visible = false
