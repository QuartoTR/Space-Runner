extends Control

var network = NetworkedMultiplayerENet.new()
var mplayer 
var serverIP = IP.get_local_addresses()[0]
#var serverIP = "10.64.15.114"
var port = 8080
var Msg
var username = ""
var username_valid = false
onready var popup1 = get_node("Background/Popup1")
onready var popup2 = get_node("Background/Popup2")
onready var popup3 = get_node("Background/Popup3")
onready var Click = get_node("Click_sound")

# Declare member variables here. Examples:
# Player info, associate ID to data
var player_info = {}
# Info we send to other players
var my_info = { name : "Ton Daron" }

func _ready():
	var texture = $Viewport.get_texture()
	$Background/Logo.texture = texture

func _on_Host_pressed() -> void:
	if len(username)==0:
		popup1.hide()
		popup2.hide()
		popup3.show()
	if username_valid:
		Click.play()
		_connect_to_server()
		save(username)
		if get_tree().change_scene("res://src/tscn/Game.tscn") != OK:
			print("Unexpected error with the scene changement")
		
func _on_Join_pressed() -> void:
	if len(username)==0:
		popup1.hide()
		popup2.hide()
		popup3.show()
	if username_valid:
		Click.play()
		if get_tree().change_scene("res://src/tscn/Game.tscn") != OK:
			print("Unexpected error with the scene changement")

func _on_Username_text_entered(new_text) -> void:
	username = new_text
	if len(username) <= 18 && len(username) > 0:
		username_valid = true
		popup1.hide()
		popup3.hide()
		popup2.show()
	elif len(username) == 0:
		username_valid = false
		popup1.hide()
		popup2.hide()
		popup3.show()
	else:
		username_valid = false
		popup2.hide()
		popup3.hide()
		popup1.show()
		
func get_username():
	return username
		
func _on_Quit_pressed():
	get_tree().quit()

func sendToServer(player,mess):
	print(mess)
	player.send_bytes(mess.to_ascii())

remote func send_pos() -> void:
	sendToServer(mplayer,"xxxxxxxxx0")

func _connect_to_server():
	network.create_client(serverIP,port)
	get_tree().set_network_peer(network)
	mplayer = get_tree().multiplayer
	print("Connected to server")

func save(content):
	var file = File.new()
	file.open("res://src/dat/save_game.dat", File.WRITE)
	file.store_string(content)
	file.close()
