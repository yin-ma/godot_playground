extends Node

var peer = ENetMultiplayerPeer.new()
var addr = "localhost"
var port = 27016

var players = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(peer_connected)
	
	players[1] = %NameEdit.text
	add_player(1)
	
	
func add_player(id):
	var player = load("res://player.tscn").instantiate()
	player.player_id = id
	player.name = str(id)
	player.player_name = players[id]
	%VBoxContainer.add_child(player)
	

func peer_connected(id):
	print("%s connected to server" % id)

func _on_join_pressed() -> void:
	peer.create_client(addr, port)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(connected_to_server)
	
func connected_to_server():
	send_name.rpc_id(1, multiplayer.get_unique_id(), %NameEdit.text)

@rpc("any_peer", "call_remote")
func send_name(id, name):
	players[id] = name
	add_player(id)

func _on_print_pressed() -> void:
	print(players)
