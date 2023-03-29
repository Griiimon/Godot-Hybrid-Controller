extends RigidBody2D


var initial_position: Vector2

func _ready():
	initial_position= global_position

func _integrate_forces(state):
	state.transform.origin= initial_position
	state.angular_velocity= 10
