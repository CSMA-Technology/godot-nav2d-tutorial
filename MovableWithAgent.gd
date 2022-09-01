extends KinematicBody2D

export (String) var goal
onready var goal_pos = get_node(goal).global_position
export var speed = 50
export var arrival_tolerance = 10
#export var nav_layer = 1
#var path = null
#var path_idx = 0

func _ready():
	$NavigationAgent2D.set_target_location(goal_pos)

func _physics_process(delta):
	if global_position.distance_to(goal_pos) <= arrival_tolerance:
		queue_free()
	var next_location = $NavigationAgent2D.get_next_location()
	var direction = (next_location - global_position).normalized()
	var movement = direction * speed
	$NavigationAgent2D.set_velocity(movement * delta)



func _on_NavigationAgent2D_velocity_computed(safe_velocity):
	move_and_collide(safe_velocity)
