extends Camera2D

# Define zoom levels
@export var normal_zoom: Vector2 = Vector2(1, 1)
@export var max_zoom_out: Vector2 = Vector2(1.5, 1.5) # Change as desired

# Distance threshold for zoom-out effect (how close to the camera edge to start zooming)
@export var zoom_distance_threshold: float = 50.0
var  dis_decide = 300
# Reference to the player node
@onready var player: Node2D =$"../Hero"
func _process(delta: float) -> void:
	rotation = 0
	position.x = player.position.x
	if player:
		# Get player's position in global coordinates
		var player_pos = player.global_position

		# Get the viewport size
		var viewport_size: Vector2 = get_viewport().get_size()
		# Use the current camera zoom for calculations
		var current_zoom: Vector2 = zoom
		
		# Calculate the visible area of the camera in world coordinates
		var camera_position: Vector2 = global_position
		var viewport_rect: Rect2 = Rect2(
			camera_position - (viewport_size / (2 * current_zoom)), 
			viewport_size / current_zoom
		)
		# Calculate distance of player to each side of the viewport
		var distance_to_left: float = abs(player_pos.x - viewport_rect.position.x)
		var distance_to_right: float = abs((viewport_rect.position.x + viewport_rect.size.x) - player_pos.x)
		var distance_to_top: float = abs(player_pos.y - viewport_rect.position.y)
		#var distance_to_bottom: float = abs((viewport_rect.position.y + viewport_rect.size.y) - player_pos.y)
		var distance_to_bottom: float = abs(700 - player_pos.y)

		
		
		var min_distance: float = min(distance_to_left, distance_to_right, distance_to_top)
		
		#print("bottom - ",distance_to_bottom)
		#print("min - ",min_distance)
		# Adjust zoom based on proximity to the camera view boundary
		
		if 2*(1 - (0.5*distance_to_bottom)/350) >=1:
			zoom = Vector2(2*(1 - (0.5*distance_to_bottom)/350),2*(1 - (0.5*distance_to_bottom)/350))
			if distance_to_bottom > 400:
				position.y = player.position.y
			else:
				position.y = player.position.y+400
		else:
			zoom = Vector2(1,1)
			position = position.lerp(player.global_position+Vector2(100,100), 0.1)
