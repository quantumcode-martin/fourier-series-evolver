extends Node2D

var circle_scene = preload("res://Circle.tscn")
var pen_scene = preload("res://Pen.tscn")

onready var circle_viewport = $Circles

var fgenom:Dictionary

func init(fgenom:Dictionary):
	var leave_circle = circle_viewport
	
	self.fgenom = fgenom
	for n in fgenom:
		var radius = fgenom[n]['radius']
		var angle = fgenom[n]['angle']
		
		var circle:Circle = circle_scene.instance()
		circle.frequency_multiplier = n
		circle.radius = radius
		circle.angle = angle
		leave_circle.add_child(circle)
		leave_circle = circle
	
	var pen = pen_scene.instance()
	leave_circle.add_child(pen)
	pen.remote_path = pen.get_path_to($Pen/Pen)
	
	
	pass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
