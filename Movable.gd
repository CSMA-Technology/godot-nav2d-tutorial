extends KinematicBody2D

export (NodePath) var goal
onready var goal_pos = get_node(goal).global_position
export var speed = 50
export var arrival_tolerance = 10
export var flip_orientation = false

var path = null

func _physics_process(delta):
	if global_position.distance_to(goal_pos) <= arrival_tolerance:
		queue_free()
	move_towards_goal(delta * speed)


func move_towards_goal(speed):
	var direction = (goal_pos - global_position).normalized()
	var movement = direction * speed
	
#	look_at(global_position + (direction * (-1 if flip_orientation else 1)))
	move_and_collide(movement)
