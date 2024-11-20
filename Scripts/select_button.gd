extends TextureButton
signal level_selected
@export var level_num: int = 1 #value which will display on the level button
@export var locked: bool = true: #state of level
	set(value):
		locked = value
		level_locked() if locked else level_unlocked()
func _ready() -> void:
	level_locked() if locked else level_unlocked() #if locked or unlocked
# Called when the node enters the scene tree for the first time.
func level_locked() -> void:
	level_state(true)

func level_unlocked() -> void:
	level_state(false)
	
func level_state(value: bool) -> void:
	disabled = value
	$Label.visible = not value
	$Label.text = str(level_num)


func _on_pressed() -> void:
	level_selected.emit(level_num)
