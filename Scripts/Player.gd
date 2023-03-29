extends CharacterBody2D


@export var speed: float = 30.0
@export var jump_velocity: float = 400.0

@export var rigidbody: RigidBody2D
@export var mass: float= 10.0
@export var rigidbody_feedback: float= 1.0

@onready var ground_check = $RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	rigidbody.mass= mass
	%"Mass Slider".value= mass
	%"Feedback Slider".value= rigidbody_feedback


func _physics_process(delta):
	var key_pressed= false
	
	if not is_on_anything():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_anything():
		velocity.y = -jump_velocity
		key_pressed= true
		
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		key_pressed= true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	var diff_velocity: Vector2= rigidbody.desired_velocity - rigidbody.linear_velocity
	
	if diff_velocity.length() > 0:
		if not key_pressed:
			global_position= rigidbody.global_position
			if is_on_anything():
				rigidbody.stop()
		else:
			global_position= lerp(global_position, rigidbody.global_position, rigidbody_feedback)
	
	move_and_slide()


func _on_feedback_slider_drag_ended(value_changed):
	rigidbody_feedback= %"Feedback Slider".value
	print("Rigidbody feedback ", rigidbody_feedback)


func _on_mass_slider_drag_ended(value_changed):
	rigidbody.mass= %"Mass Slider".value 


func is_on_anything()-> bool:
	return is_on_floor() or ground_check.is_colliding()
