extends Node2D
class_name Circle

export(float) var radius:float setget set_radius
export(float) var angle:float
export(int) var frequency_multiplier

var child_node

func set_radius(value):
	radius = value
	update()

#func _ready():
#	update_child_node()

func _process(delta):
	if not Engine.editor_hint:
		if child_node != null:
			var t = TimeManager.time*frequency_multiplier
			child_node.position = radius*Vector2(cos(t+angle),sin(t+angle))

func _draw():
#	draw_circle(Vector2.ZERO, radius, Color.orange)
	var c = Color.orange
	c.a = 0.5
	draw_arc(Vector2.ZERO, radius, 0.0, 2*PI, 200, c, 3, true)

func update_child_node():
	child_node = null if get_child_count()==0 else get_child(0)
