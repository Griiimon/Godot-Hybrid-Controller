extends RigidBody2D

@onready var character: CharacterBody2D= get_parent()

var desired_velocity: Vector2

var stop_body:= false


func _integrate_forces(state):
	if stop_body:
		stop_body= false
		state.linear_velocity= Vector2.ZERO
		return
	
	desired_velocity= character.global_position - global_position
	
	if character.is_on_anything():
		desired_velocity.y= 0
	
	state.linear_velocity= desired_velocity


func stop():
	stop_body= true
	global_position= character.global_position

