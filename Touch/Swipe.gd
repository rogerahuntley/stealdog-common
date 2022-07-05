extends Node

class_name Swipe

signal swiped

var swipe_start setget ,get_swipe_dir
export var minimum_dist_release = 25
export var minimum_dist_quick = 50

var swipe_dir

enum Direction {
	Up,
	Right,
	Down,
	Left
}

func _process(delta):
	if get_tree().paused:
		swipe_start = null

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			swipe_start = event.position
		elif swipe_start != null:
			var distance = swipe_start.distance_to(event.position)
			print(distance)
			if distance > minimum_dist_quick:
				calculate_swipe(swipe_start.direction_to(event.position))
	if event is InputEventScreenDrag:
		if abs(event.speed.x) > minimum_dist_quick || abs(event.speed.y) > minimum_dist_quick:
			if swipe_start != null:
				calculate_swipe(swipe_start.direction_to(event.position))
				swipe_start = null

func get_swipe_dir():
	var to_return = swipe_dir
	swipe_dir = null
	return to_return

func calculate_swipe(dist):
	if dist.x > .5:
		swipe_dir = Direction.Right
		emit_signal("swiped", "right")
	elif dist.x < -.5:
		swipe_dir = Direction.Left
		emit_signal("swiped", "left")
	elif dist.y > .5:
		swipe_dir = Direction.Down
		emit_signal("swiped", "down")
	elif dist.y < -.5:
		swipe_dir = Direction.Up
		emit_signal("swiped", "up")
