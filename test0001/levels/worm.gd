extends Node2D

var hit_flag = false
func check_all_connected():
	var nodes = []
	var pjs = []
	for child in get_children():
		if child is RigidBody2D:
			nodes.append(child)
		if child is PinJoint2D:
			pjs.append(child)
			#print(child)
	
	var nodes_count = nodes.size()
	#print(pjs.size())
	for i in nodes_count - 1:
		#print(nodes[i])
		#print(nodes[i].global_position)
		var vect = nodes[i+1].global_position - nodes[i].global_position
		#print(vect.length())
		if (i < pjs.size()):
			if vect.length() > 30.0 :
				print(i, " ", i-1, " FAR AWAY!")
				print(pjs.size())
				pjs[i].set_node_a(pjs[i].get_path())
				pjs[i].set_node_b(pjs[i].get_path())
				#pjs[i].queue_free()
				#get_parent().remove_child(pjs[i])
				#pjs[i].queue_free()
				print("broke: ", i)
				hit_flag = true
				pass
	
	
	
	
var head: RigidBody2D
#var ch7: RigidBody2D

var rng = RandomNumberGenerator.new()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	head = get_node("head")
	#ch7 = get_node("chain7")
	pass # Replace with function body.

var speed = 3000
var angle = 0

var d = 0
var counter = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (hit_flag == false):
		counter -=1
		if (counter == 0):
			angle = rng.randf_range(180,-180)
			counter = 50

		var dir = Vector2(sin(deg_to_rad(angle)), cos(deg_to_rad(angle)))
		if rng.randi_range(0,1) == 0:
			head.apply_central_impulse(dir*speed*delta)
		#else:
			#ch7.apply_central_impulse(dir*speed*delta)
		
	
	#check_all_connected()
		

#func _input(event):
	
	#if event is InputEventMouseMotion:
		#print("here")
	#$head.set_global_position(get_global_mouse_position())
#func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	print("_on_area_2d_body_shape_entered")
#	print(body)
#	print(body_rid)
#	print(body_shape_index)
#	print(local_shape_index)
#	#pass # Replace with function body.
#
#
#func _on_area_2d_body_entered(body):
#	print("_on_area_2d_body_entered")
#	print(body)
#	#pass # Replace with function body.
