extends KinematicBody2D

export (String) var goal
onready var goal_pos = get_node(goal).global_position
export var speed = 50
export var arrival_tolerance = 10
export var nav_layer = 1
var path = null
var path_idx = 0

func _physics_process(delta):
	if global_position.distance_to(goal_pos) <= arrival_tolerance:
		queue_free()
	else:
		move_towards_goal(delta * speed)


func move_towards_goal(speed):
	if not path:
		path = Navigation2DServer.map_get_path(get_world_2d().navigation_map, global_position, goal_pos, false, nav_layer)
		path_idx = 0
		return
	while global_position.distance_to(path[path_idx]) <= arrival_tolerance:
		path_idx += 1
	var direction = (path[path_idx] - global_position).normalized()
	var movement = direction * speed
	move_and_collide(movement)
