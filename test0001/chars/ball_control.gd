extends RigidBody2D

const rolling_force:float = 80.0

func _ready():
	pass
	
func _physics_process(delta):
	#look_at(get_global_mouse_position())
	#rotate(get_angle_to(get_global_mouse_position()))
	if Input.is_action_pressed("left_a"):
		set_angular_velocity(get_angular_velocity() - rolling_force*delta)
	if Input.is_action_pressed("right_d"):
		set_angular_velocity(get_angular_velocity() + rolling_force*delta)

