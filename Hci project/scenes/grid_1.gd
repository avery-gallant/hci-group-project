extends Node2D

@export var spacing : float
@export var buttonWidth : float
@export var dimensions : Vector2

var colours : Array

func _ready():
	colours = [Color(255, 0, 0), Color(24,155,204), Color(24,155,204), Color(24,155,204),
				Color(24,155,204), Color(24,155,204), Color(24,155,204), Color(24,155,204),
				Color(24,155,204), Color(24,155,204), Color(24,155,204), Color(24,155,204)]
	
	var xIndex : int = 0
	var yIndex : int = 0
	var i = 0
	for button in get_children():
		button.position = Vector2(spacing + xIndex*(buttonWidth+spacing), spacing + yIndex*(buttonWidth+spacing))
		if((xIndex+1)%int(dimensions.x) == 0): yIndex+=1
		xIndex = (xIndex+1)%int(dimensions.x)
		button.colour = colours[i]
		print(button.colour)
		i += 1
