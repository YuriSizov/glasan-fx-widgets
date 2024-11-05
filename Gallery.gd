@tool
extends Control

const LABEL_DURATION := 1.5
const LABEL_VALUES := [ "HELLO!", "NICE", "TO", "MEET", "YOU!" ]

var _label_accum: float = 0.0
var _label_index: int = 0

@onready var _electronic_label: ElectronicLabel = %ElectronicLabel


func _ready() -> void:
	_update_label(0)


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	_label_accum += delta
	if _label_accum >= LABEL_DURATION:
		_label_accum = 0.0
		_update_label(1)


func _update_label(offset: int) -> void:
	_label_index = (_label_index + offset) % LABEL_VALUES.size()
	_electronic_label.text = LABEL_VALUES[_label_index]
