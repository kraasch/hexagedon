extends Node

func load_mp3(path : String) -> AudioStreamMP3:
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	var sound : AudioStreamMP3 = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound
