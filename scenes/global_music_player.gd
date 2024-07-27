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
	GlobalEvents.play_track.connect(_play_track)
	GlobalEvents.set_music_volume.connect(_play_track)
	finished.connect(play) # loop
	_play_track(Tracks.MAIN_MENU)
	
func _init_catalogue() -> void:
	catalogue = {
		Tracks.MAIN_MENU: _track_1,
		Tracks.IN_GAME: _track_2
	}

func _set_track(trackName: Tracks) -> void:
	var track = catalogue[trackName]
	assert(track != null)
	self.stream = catalogue[trackName]
	
func _play_track(trackName: Tracks) -> void:
	_set_track(trackName)
	play()
	
func _set_volume(volume: Tracks) -> void:
	self.volume_db = volume
	
