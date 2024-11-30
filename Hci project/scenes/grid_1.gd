extends Node2D

@export var spacing : float
@export var buttonWidth : float
@export var dimensions : Vector2

func _ready():
	position.x = 420
	position.y = 0
	var xIndex : int = 0
	var yIndex : int = 0
	for button in get_children():
		button.position = Vector2(spacing + xIndex*(buttonWidth+spacing), spacing + yIndex*(buttonWidth+spacing))
		if((xIndex+1)%int(dimensions.x) == 0): yIndex+=1
		xIndex = (xIndex+1)%int(dimensions.x)
