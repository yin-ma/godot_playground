extends Control

var total = 0

var player_name = "":
	set(name):
		player_name = name
		%Name.text = name
		
@export var player_id = 1:
	set(id):
		player_id = id
		%MultiplayerSynchronizer.set_multiplayer_authority(id)

func _enter_tree() -> void:
	#%MultiplayerSynchronizer.set_multiplayer_authority(player_id)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Total.text = str(total)


func _on_up_pressed() -> void:
	if player_id == multiplayer.get_unique_id():
		total += 1


func _on_down_pressed() -> void:
	if player_id == multiplayer.get_unique_id():
		total -= 1
