extends "res://Characters/TemplateCharacter.gd"

const FOV_TOLERANCE = 20
const MAX_DETECTION_RANGE = 320
const RED = Color.red
const WHITE = Color.white

var player

func _ready():
	
	player = get_node("/root").find_node("PlayerCharacter", true, false)


func _process(delta):
	if player_in_FOV() and player_in_LOS():
		$Torch.color = RED
	else:
		$Torch.color = WHITE


func player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_player = (player.position - global_position).normalized()
	
	if abs(direction_to_player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false


func player_in_LOS():
	var space = get_world_2d().direct_space_state
	var LOS_to_player = space.intersect_ray(global_position, player.global_position, [self], collision_mask)
	
	if not LOS_to_player:
		return false
	
	var distance_to_player = player.global_position.distance_to(global_position)
	if LOS_to_player.collider == player and distance_to_player < MAX_DETECTION_RANGE:
		return true
	else:
		return false
		
	
