extends AudioStreamPlayer # To be autoloaded

enum Tracks {
	MAIN_MENU,
	IN_GAME
}

const _track_1: AudioStream = preload("res://music/Punch Deck - Non-Euclidean Geometry.mp3")
const _track_2: AudioStream = preload("res://music/Punch Deck - DRAGON VS GOOSE- BATTLE OF THE CENTURY.mp3")

var catalogue: Dictionary

func _ready() -> void:
	_init_catalogue()
	finished.connect(play) # loop
	self.volume_db = -10
	play_track(Tracks.MAIN_MENU)
	
func _init_catalogue() -> void:
	catalogue = {
		Tracks.MAIN_MENU: _track_1,
		Tracks.IN_GAME: _track_2
	}

func _set_track(trackName: Tracks) -> void:
	var track = catalogue[trackName]
	assert(track != null)
	self.stream = catalogue[trackName]
	
func play_track(trackName: Tracks) -> void:
	_set_track(trackName)
	play()
	
