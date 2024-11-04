extends Node2D

@export var spacing : float
@export var buttonWidth : float
@export var dimensions : Vector2

func _ready():
	position.x = 50
	position.y = 50
	var xIndex : int = 0
	var yIndex : int = 0
	for button in get_children():
		button.position = Vector2(spacing + xIndex*(buttonWidth+spacing), spacing + yIndex*(buttonWidth+spacing))
		if((xIndex+1)%int(dimensions.x) == 0): yIndex+=1
		xIndex = (xIndex+1)%int(dimensions.x)
		
