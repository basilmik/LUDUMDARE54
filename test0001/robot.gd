extends RigidBody2D

const rolling_force:float = 80.0

var small_ball_sprite: Sprite2D
var arm_sprite: Sprite2D
var arm_cs: CollisionShape2D
var big_ball_cs: CollisionShape2D
var big_ball_sprite: Sprite2D
var marker: Marker2D

var scaling_q: float = 1.0
var arm_rad: float
var new_pin_joint

var can_grab: bool = false
var prev_marker_pos

const ARM_LEN_MIN = 8

func _ready():
	
	arm_rad = ARM_LEN_MIN
	mass = 50

	small_ball_sprite = get_node("SmallBall")

	
	big_ball_cs = get_node("BigBall_cs")
	big_ball_sprite = get_node("Ball")
	marker = get_node("Marker")
	#arm_sprite = get_node("Arm_body/Arm")
	#arm_cs = get_node("Arm_body/Arm_cs")
	
	arm_sprite = get_node("Arm")
	arm_cs = get_node("Arm_cs")
	
	arm_sprite.global_scale.x = scaling_q
	arm_cs.global_scale.x = scaling_q
	prev_marker_pos = marker.get_global_position()
	#$Arm_body.add_collision_exception_with($".")

var grabbed_node

func _physics_process(delta):
	#var collision_info = move_and_collide(linear_velocity * delta)
	#if collision_info:
		#linear_velocity = linear_velocity.bounce(collision_info.get_normal())

	var rads = (big_ball_sprite.global_position - get_global_mouse_position()).angle()
	var angl = rad_to_deg(rads) + 180
	
	var x_on_rad = scaling_q*arm_rad*cos(rads)
	var y_on_rad = scaling_q*arm_rad*sin(rads)
	var x = big_ball_sprite.global_position.x - x_on_rad
	var y = big_ball_sprite.global_position.y - y_on_rad

	arm_sprite.global_position = Vector2(x,y)
	arm_cs.global_position = Vector2(x,y)
	
	var marker_pos = Vector2(x - x_on_rad, y - y_on_rad)
	
	##var marker_pos = Vector2(big_ball_sprite.global_position.x - scaling_q*2*arm_rad*cos(rads),
	##big_ball_sprite.global_position.y - scaling_q*2*arm_rad*sin(rads))
		#big_ball_sprite.global_position.x - scaling_q*(arm_rad-5)*cos(rads), 
	#big_ball_sprite.global_position.y - scaling_q*(arm_rad-5)*sin(rads))
	
	##
	marker.global_position = marker_pos
	
	#$Arm_body.global_position = marker_pos
	#$Arm_body.move_and_collide(Vector2(x,y))
	#$Arm_body.move_and_collide(Vector2(x,y) - arm_cs.global_position)
#	$Arm_body.move_and_collide(marker_pos - marker.global_position)
	##$Arm_body.move_and_collide(marker_pos - marker.global_position)
	
	arm_sprite.look_at(get_global_mouse_position())
	arm_cs.look_at(get_global_mouse_position())
	small_ball_sprite.look_at(get_global_mouse_position())
	
	
	if new_pin_joint != null:
		#pass
		#var grabbed_node = get_parent().get_node(new_pin_joint.get_node_b())
		#grabbed_node.set_global_position(marker.get_global_position())
		
		#grabbed_node.set_global_position(marker.get_global_position())
		
		grabbed_node.move_and_collide(marker.get_global_position() - grabbed_node.global_position)
		
		#grabbed_node.set_global_position(get_global_mouse_position())
		print("mouse pos: ", int(get_global_mouse_position().x), " ", int(get_global_mouse_position().y))
		print("marker pos: ", int(marker.get_global_position().x), " ", int(marker.get_global_position().y))
		print("grabbed_node pos: ", int(grabbed_node.get_global_position().x), " ", int(grabbed_node.get_global_position().y))
	
		#new_pin_joint.set_global_position(marker.get_global_position())
		
		#print("grabbed_node pos: ", int(grabbed_node.get_global_position().x), " ", int(grabbed_node.get_global_position().y))
		#print("new_pin_joint pos: ", int(new_pin_joint.get_global_position().x), " ", int(new_pin_joint.get_global_position().y))
		#print("marker pos: ", int(marker.get_global_position().x), " ", int(marker.get_global_position().y))
	
		

	#print("a_v: ", get_angular_velocity())
	if Input.is_action_pressed("left_a"):
		print("left_a")
		set_angular_velocity(get_angular_velocity() - rolling_force*delta)
		
	elif Input.is_action_pressed("right_d"):
		print("right_d")
		set_angular_velocity(get_angular_velocity() + rolling_force*delta)
	else:
		set_angular_velocity(0)
		#set_linear_velocity(Vector2(0,0))
			
	if Input.is_action_pressed("left_click"):
			if (arm_rad < 30):
				arm_rad+=1
				#scaling_q = arm_rad/ARM_LEN_MIN
				arm_sprite.scale.x = arm_rad/ARM_LEN_MIN
				arm_cs.scale.x = arm_rad/ARM_LEN_MIN

	if Input.is_action_just_released("left_click"):
			arm_rad = ARM_LEN_MIN
			scaling_q = 1
			arm_sprite.scale.x = 1.0
			arm_cs.scale.x = 1.0
	
	if Input.is_action_just_released("e_press"):
		#var static_replacement = StaticBody2D.new()
		#static_replacement.set_name("ch6_")
		#static_replacement.set_global_position($"../worm".)
		pass
		
	
	if Input.is_action_pressed("space"):
		can_grab = true
			
	if Input.is_action_just_released("space"):
		can_grab = false
		if (created):
			##var node_save = get_parent().get_node(new_pin_joint.get_node_b())
			##get_parent().remove_child(new_pin_joint)
						
			##new_pin_joint = null
			created = false
			##node_save.get_global_position()

			#THIS
			##node_save.set_global_position(marker.get_global_position())



var created = false
func _on_end_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("end touch ", body.name, " pos: ", marker.global_position)
	
	if (body.name != "TileMap" && can_grab == true && created == false):
		new_pin_joint = PinJoint2D.new()
		##new_pin_joint.set_name("new_joint_pin")
		##new_pin_joint.set_global_position(marker.global_position)
		
		##new_pin_joint.set_node_a($".".get_path())
		
		var static_replacement = CharacterBody2D.new()
		grabbed_node = static_replacement
		static_replacement.set_name(body.name + "_")

		###static_replacement.set_global_position(body.get_global_position())
		
		#####static_replacement.set_global_position(body.global_position)
		
		var body_parent = body.get_parent()
		
		
		#create new static body in the same place with the same children
		var nodes = []
		var pins = []
		var body_idx = 0
		for i in body_parent.get_children():
			if i is PinJoint2D:
				pins.append(i)
			else:
				nodes.append(i)
				print(i.get_position())  
				
		var i = 0
		for node in nodes:
			if node == body:
				body_idx = i
				break
			else:
				i+=1
		
		#print("static_replacement.print_tree_pretty()\n")
		#static_replacement.print_tree_pretty()
		
		#moving all body child nodes to new node
		for body_child_node in body.get_children():
			body.remove_child(body_child_node)
			static_replacement.add_child(body_child_node)
#			if body_child_node is CollisionShape2D:
#				print(body_child_node.get_shape().radius)
#				print(body_child_node.get_shape().radius)
#				#body_child_node.get_shape().radius+=5
#				print(body_child_node.position)
#				print(body_child_node.disabled)
			#print("\nadded ", body_child_node)
			#static_replacement.print_tree_pretty()
			
		print("body global position ", body.get_global_position())
		print("body position ", body.get_position())
		static_replacement.set_position(body.get_global_position())
		static_replacement.get_global_position()

#
		body.replace_by(static_replacement)

		static_replacement.set_collision_layer_value(1, true)
		static_replacement.set_collision_mask_value(1, true)
		static_replacement.set_collision_layer_value(2, true)
		static_replacement.set_collision_mask_value(2, true)
		body_parent.print_tree_pretty()
		
		static_replacement.add_collision_exception_with(self)
		#static_replacement.add_collision_with($"../TileMap")
		
		#$"../TileMap".set_collision_layer_value(3, true)
		#$"../TileMap".set_collision_mask_value(3, true)
		static_replacement.set_collision_layer_value(3, true)
		static_replacement.set_collision_mask_value(3, true)
		
		add_collision_exception_with(static_replacement)
		#$".".add_collision_with(static_replacement)   
		#body.queue_free()
		
		if pins.size() > 0:
			i = body_idx
			print("s: ", pins.size())
			print("i: ", i)
			if i != 0:
				print("b: ", pins[i-1].get_node_b())
				pins[i-1].set_node_b(static_replacement.get_path())
				print("b: ", pins[i-1].get_node_b())
				
			if i < (pins.size() - 1):
				print("a: ", pins[i+1].get_node_a())
				pins[i+1].set_node_a(static_replacement.get_path())
				print("a: ", pins[i+1].get_node_a())
			
		
		##new_pin_joint.set_node_b(static_replacement.get_path())
		
		##get_parent().add_child(new_pin_joint)
		
		#print("\nbody.get_parent().print_tree_pretty()\n")
		#get_parent().print_tree_pretty()     
		#print("\n")
		
		#add_child(new_pin_joint)
		
		#print("pos: ", new_pin_joint.get_global_position())
		
		created = true         
		
	pass # Replace with function body.
