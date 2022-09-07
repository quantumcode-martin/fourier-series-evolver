extends CenterContainer

var circle_scene = preload("res://Circle.tscn")
var pen_scene = preload("res://Pen.tscn")

onready var circle_viewport = $Circles

var fgenom:Dictionary

signal selected

func init(fgenom:Dictionary):
	var leaf_circle = circle_viewport
	
	self.fgenom = fgenom
	for n in fgenom:
		var radius = fgenom[n]['radius']
		var angle = fgenom[n]['angle']
		
		var circle:Circle = circle_scene.instance()
		circle.frequency_multiplier = n
		circle.radius = radius
		circle.angle = angle
		
		
		leaf_circle.add_child(circle)
		if leaf_circle.has_method("update_child_node"):
			leaf_circle.update_child_node()
		else: #first circle
			circle.position = leaf_circle.size/2
			circle.self_modulate = Color.transparent
		leaf_circle = circle
	
	var pen = pen_scene.instance()
	leaf_circle.add_child(pen)
	leaf_circle.update_child_node()
	pen.remote_path = pen.get_path_to($Pen/Pen)
	
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pen/Pen.modulate = Color.from_hsv(TimeManager.time/(2*PI), 1.0, 1.0)

func is_selected():
	return $Button.focus_mode

func _on_Button_pressed():
	emit_signal("selected")
